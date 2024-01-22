import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class EmployeSalary extends StatefulWidget {
  final Map<String, dynamic>? employeData;
  const EmployeSalary({super.key, this.employeData});

  @override
  State<EmployeSalary> createState() => _EmployeSalaryState();
}

class _EmployeSalaryState extends State<EmployeSalary> {
  final yearController = TextEditingController();

  final monthController = TextEditingController();
  //selection of month year
  List<int> years = [];
  int? selectedYear; // Store the selected year
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  String? selectedMonth;
  int? startOfMonth;
  int? endOfMonth;
  List<QueryDocumentSnapshot> documentList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchCurrentMonthAndCalculateDays();
    calculateAttendance();
    calculateLateAndOvertime();
    //selection of month year
    int currentYear = DateTime.now().year;
    int startYear = 1990;
    for (int year = currentYear; year >= startYear; year--) {
      years.add(year);
    }
    selectedYear = currentYear;

    selectedMonth = DateFormat('MMMM').format(DateTime.now());
  }

  int presentDays = 0;
  int absentDays = 0;
  int leaveDays = 0;
  int totalLateMinutes = 0;
  int totalOvertimeMinutes = 0;
  int totalDays = 0;
  double absentDeduction = 0.0;
  double totalLateMinutsDeduction = 0.0;
  double totalDeduction = 0;
  double salary = 0;
  double payableSalary = 0;
  double perdaySalary = 0;
  int workingDays = 0;

  Future<void> calculateAttendance() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('checkInOut')
          .where(
            'currentUserId',
            isEqualTo: widget.employeData!['id'],
          )
          .where('unixTimestamp', isGreaterThanOrEqualTo: startOfMonth)
          .where('unixTimestamp', isLessThan: endOfMonth)
          .get();

      for (final doc in querySnapshot.docs) {
        final bool isPresent = doc['isPresent'];
        final bool isLeave = doc['isLeave'];
        final bool isAbsent = doc['isAbsent'];

        if (isPresent) {
          presentDays++;
          setState(() {});
        }
        if (isLeave) {
          leaveDays++;
          setState(() {});
        }
        if (isAbsent) {
          absentDays++;
          setState(() {});
        }
      }
      workingDays = totalDays - (presentDays + absentDays + leaveDays);

      absentDays = workingDays + absentDays;
      setState(() {});

      print('Present Days: $presentDays');
      print('Absent Days: $absentDays');
      print('Leave Days: $leaveDays');
    } catch (e) {
      print('Error  Why $e');
    }
  }

  Future<void> calculateLateAndOvertime() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshotCheckInOut =
          await _firestore
              .collection('checkInOut')
              .where('currentUserId', isEqualTo: widget.employeData!['id'])
              .where('unixTimestamp', isGreaterThanOrEqualTo: startOfMonth)
              .where('unixTimestamp', isLessThan: endOfMonth)
              .get();

      for (final doc in querySnapshotCheckInOut.docs) {
        final String checkInTimeString = doc['checkInTime'];
        final String checkOutTimeString = doc['checkOutTime'];

        final DateTime checkInTime =
            parseTimeStringToDateTime(checkInTimeString);
        final DateTime checkOutTime =
            parseTimeStringToDateTime(checkOutTimeString);

        final DateTime expectedCheckInTime = DateTime(
          checkInTime.year,
          checkInTime.month,
          checkInTime.day,
          9,
          0,
        ); // 9:00 AM

        final DateTime expectedCheckOutTime = DateTime(
          checkOutTime.year,
          checkOutTime.month,
          checkOutTime.day,
          17,
          0,
        ); // 5:00 PM

        if (checkInTime.isAfter(expectedCheckInTime)) {
          final Duration lateDuration =
              checkInTime.difference(expectedCheckInTime);
          totalLateMinutes += lateDuration.inMinutes;
        }

        if (checkOutTime.isAfter(expectedCheckOutTime)) {
          final Duration overtimeDuration =
              checkOutTime.difference(expectedCheckOutTime);
          totalOvertimeMinutes += overtimeDuration.inMinutes;
        }
        String salaryString = widget.employeData!['salary'];
        salary = double.tryParse(salaryString) ??
            0.0; // Default to 0.0 if parsing fails

        perdaySalary = salary / totalDays;

        if (absentDays > 0) {
          absentDeduction = perdaySalary * absentDays;
        } else {
          absentDeduction = 0;
        }
      }
      double totalWorkingMinutesPerDay = 8 * 60; // 8 hours * 60 minutes
      double perMinuteSalary = perdaySalary / totalWorkingMinutesPerDay;
      totalLateMinutsDeduction = totalLateMinutes * perMinuteSalary;

      totalDeduction = absentDeduction + totalLateMinutsDeduction;
      payableSalary = salary - totalDeduction;

      setState(() {});
      print('Total Late Minutes: $totalLateMinutes');
      print('Total Overtime Minutes: $totalOvertimeMinutes');
      print('Absent Deduction $absentDeduction');
    } catch (e) {
      print('Error: $e');
    }
  }

  DateTime parseTimeStringToDateTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    // Construct a DateTime object with the correct time, but using an arbitrary date (e.g., 2000-01-01)
    return DateTime(2000, 1, 1, hour, minute);
  }

  int getTotalDaysInMonth(String monthYear) {
    List<String> parts = monthYear.split(' ');
    String month = parts[0]; // e.g., "August"
    int year = int.parse(parts[1]); // Convert the year string to an int

    int monthIndex = _getMonthNumber(month);
    int daysInMonth = DateTime(year, monthIndex + 1, 0).day;
    return daysInMonth;
  }

  int _getMonthNumber(String monthName) {
    switch (monthName.toLowerCase()) {
      case 'january':
        return 1;
      case 'february':
        return 2;
      case 'march':
        return 3;
      case 'april':
        return 4;
      case 'may':
        return 5;
      case 'june':
        return 6;
      case 'july':
        return 7;
      case 'august':
        return 8;
      case 'september':
        return 9;
      case 'october':
        return 10;
      case 'november':
        return 11;
      case 'december':
        return 12;
      default:
        return 1; // Default to January
    }
  }

  Future<void> fetchCurrentMonthAndCalculateDays() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('checkInOut')
              .where('currentUserId', isEqualTo: widget.employeData!['id'])
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;
        String currentMY = documentSnapshot.data()!['currentMY'];
        // String salaryString = widget.employeData!['salary'];
        // double salary = double.tryParse(salaryString) ?? 0.0;
        // double total = totalDays.toDouble();
        // absentDeduction = (salary / total) * absentDays;
        // print('Absent Days is $absentDays');
        // if (totalDays > 0 && absentDays > 0) {
        //   double result = (salary / total);
        //   absentDeduction = result * absentDays;
        //   print('Absent Deduction: $absentDeduction');
        // } else {
        //   print(
        //       'Cannot calculate absent deduction due to zero totalDays or absentDays.');
        //   absentDeduction = 0;
        // }
        setState(() {
          totalDays = getTotalDaysInMonth(currentMY);
        });
        // print('Total Absent Deduction is $absentDeduction');
        print('Total days in $currentMY: $totalDays');
      } else {
        print('No documents found for the current user.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> generateAndShowPDF(
      List<QueryDocumentSnapshot> documentList) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Employee Salary Report',
                  style: pw.TextStyle(
                    fontSize: 26,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Name: ${widget.employeData!['name']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Employee Type: ${widget.employeData!['type']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Roster: 9 to 5',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Email: ${widget.employeData!['email']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Bank Name: ${widget.employeData!['bankName']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Account Number: ${widget.employeData!['accountNo']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Total Present Days in month: $presentDays',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Total Absent Days in month: $absentDays',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Total Leave Days in month: $leaveDays',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Total Late Minutes in month: $totalLateMinutes',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Total Absent Deduction in month: ${absentDeduction.toStringAsFixed(0)}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Total Late Minutes Deduction in month: ${totalLateMinutsDeduction.toStringAsFixed(0)}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Basic salary in month: $salary',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Total Deduction in month: ${totalDeduction.toStringAsFixed(0)}',
                  style: const pw.TextStyle(fontSize: 14),
                ),

                pw.Text(
                  'Total Payable Salary in month: ${payableSalary.toStringAsFixed(0)}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                //
              ],
            ),
          );
        },
      ),
    );

    // pdf.addPage(
    //   pw.Page(
    //     build: (pw.Context context) {
    //       return pw.Center(
    //         child: pw.Column(
    //           // mainAxisAlignment: pw.MainAxisAlignment.start,
    //           // crossAxisAlignment: pw.CrossAxisAlignment.center,
    //           children: [
    //             pw.Text(
    //               'Employee Salary Report',
    //               style: pw.TextStyle(fontSize: 26),
    //             ),
    //             pw.SizedBox(height: 20),
    //             pw.Text('Name: ${widget.employeeData!['name']}'),
    //             pw.Text('Employee Type: ${widget.employeeData!['type']}'),
    //             pw.Text('Roster: 9 to 5'),
    //             pw.Text('Email: ${widget.employeeData!['email']}'),
    //             pw.Text('Bank Name: ${widget.employeeData!['bankName']}'),
    //             pw.Text('Account Number: ${widget.employeeData!['accountNo']}'),
    //             pw.Text('Total Present Days in month: $presentDays'),
    //             pw.Text('Total Absent Days in month: $absentDays'),
    //             pw.Text('Total Leave Days in month: $leaveDays'),
    //             pw.Text('Total Late Minuts in month: $totalLateMinutes'),
    //             pw.Text('Total Absent Deduction in month: $absentDeduction'),
    //             pw.Text('Total Late Minuts Deduction in month: $lateMinutsDeduction'),
    //             pw.Text('Basic salary in month: $salary'),
    //             pw.Text('Total Deduction in month: $totalDeduction'),
    //             pw.Text('Bouns in month: $enteredValue'),
    //             pw.Text('Total Payable Salary in month: $payableSalary'),
    //             // Create table for document list
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );

    final Uint8List pdfBytes = await pdf.save();
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/employee_roster.pdf');
    await file.writeAsBytes(pdfBytes);

    OpenFile.open(file.path, type: 'application/pdf');
  }

  void convertMonthToUnixTimestamps(String? selectedMonth) {
    if (selectedMonth != null) {
      int selectedMonthIndex = months.indexOf(selectedMonth) + 1;
      DateTime startDateTime = DateTime(selectedYear!, selectedMonthIndex);
      DateTime endDateTime =
          startDateTime.add(Duration(days: 32)).subtract(Duration(seconds: 1));

      startOfMonth = startDateTime.millisecondsSinceEpoch ~/ 1000;
      endOfMonth = endDateTime.millisecondsSinceEpoch ~/ 1000;

      // Use startOfMonth and endOfMonth in your Firestore query
      print("Start of month: $startOfMonth");
      print("End of month: $endOfMonth");
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MySize.size30,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: TextFieldWidget(
            //         controller: yearController,
            //         hintText: '2023',
            //         sufixIcon: Padding(
            //           padding: const EdgeInsets.all(16),
            //           child: Image.asset(
            //             AppIcons.calander,
            //             height: 10,
            //             width: 10,
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: MySize.size50,
            //     ),
            //     Expanded(
            //       child: TextFieldWidget(
            //         controller: monthController,
            //         hintText: 'November',
            //         sufixIcon: Padding(
            //           padding: const EdgeInsets.all(16),
            //           child: Image.asset(
            //             AppIcons.calander,
            //             height: 10,
            //             width: 10,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: MySize.size10, right: MySize.size6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(MySize.size10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),

                    value: selectedMonth,
                    // Set the selected month as the value
                    onChanged: (String? month) {
                      setState(() {
                        selectedMonth = month; // Update the selected month
                        convertMonthToUnixTimestamps(
                            month); // Convert month to timestamps
                      });
                    },
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        // Set the initial value to null
                        child: Text('Select Month'),
                      ),
                      ...months.map((String month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(month),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: MySize.size10, right: MySize.size6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(MySize.size10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButton<int>(
                    underline: Container(),
                    value: selectedYear,
                    // Set the selected year as the value
                    onChanged: (int? year) {
                      setState(() {
                        selectedYear = year; // Update the selected year
                      });
                    },
                    items: [
                      const DropdownMenuItem<int>(
                        value: null,
                        // Set the initial value to null
                        child: Text('Select Year'),
                      ),
                      ...years.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: MySize.size12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  AppIcons.print,
                  height: MySize.size14,
                  width: MySize.size14,
                ),
                SizedBox(
                  width: MySize.size16,
                ),
                GestureDetector(
                  onTap: () {
                    generateAndShowPDF(documentList);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppIcons.download,
                      height: MySize.size14,
                      width: MySize.size14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MySize.size30,
            ),
            Row(
              children: [
                Text(
                  'Current Status: ',
                  style: poppineRegular.copyWith(
                      fontSize: MySize.size12, color: primaryColor),
                ),
                Text(
                  // ' Paid',
                  widget.employeData!['salaryStatus'],
                  style: poppinBold.copyWith(
                      fontSize: MySize.size12,
                      color: widget.employeData!['salaryStatus'] == 'UnPaid'
                          ? redColor
                          : primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: MySize.size6,
            ),
            StreamBuilder(
                stream: _firestore
                    .collection('checkInOut')
                    .where('currentUserId',
                        isEqualTo: widget.employeData!['id'])
                    .where('unixTimestamp',
                        isGreaterThanOrEqualTo: startOfMonth)
                    .where('unixTimestamp', isLessThan: endOfMonth)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text('No Data Found'));
                  } else if (snapshot.data.docs.isEmpty) {
                    return const Center(child: Text('No Data found'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        basicInformationWidget(),
                        SizedBox(
                          height: MySize.size15,
                        ),
                        attendanceInformationWidget(),
                        SizedBox(
                          height: MySize.size15,
                        ),
                        deductionInformationWidget(),
                        SizedBox(
                          height: MySize.size15,
                        ),
                        summaryWidget(),
                      ],
                    );
                  }
                }),
            SizedBox(
              height: MySize.size50,
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryWidget() {
    return Container(
      decoration:
          BoxDecoration(color: const Color(0xff7DC247).withOpacity(0.09)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: poppinSemiBold.copyWith(
                  fontSize: MySize.size14, color: primaryColor),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            rowWidget(
                name: 'Basic Salary',
                title: '${widget.employeData!['salary']}/-'),
            rowWidget(
                name: 'Total Deduction',
                title: '${totalDeduction.toStringAsFixed(0)}/-'),
            rowWidget(
                name: 'Payable Salary',
                title: '${payableSalary.toStringAsFixed(0)}/-'),
          ],
        ),
      ),
    );
  }

  Widget deductionInformationWidget() {
    return Container(
      decoration:
          BoxDecoration(color: const Color(0xff7DC247).withOpacity(0.09)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deduction  Information',
              style: poppinSemiBold.copyWith(
                  fontSize: MySize.size14, color: primaryColor),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            rowWidget(
                name: 'Absents',
                title: '${absentDeduction.toStringAsFixed(0)}-/'),
            // rowWidget(name: 'Leaves (Unpaid)', title: '2000/-'),
            rowWidget(
                name: 'Total Late Minutes',
                title: '${totalLateMinutsDeduction.toStringAsFixed(0)}-/'),
          ],
        ),
      ),
    );
  }

  Widget attendanceInformationWidget() {
    return Container(
      decoration:
          BoxDecoration(color: const Color(0xff7DC247).withOpacity(0.09)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance  Information',
              style: poppinSemiBold.copyWith(
                  fontSize: MySize.size14, color: primaryColor),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            rowWidget(name: 'Present', title: '$presentDays'),
            rowWidget(name: 'Absents', title: '${absentDays}'),
            // rowWidget(name: 'Late Minutes (Days)', title: '02'),
            rowWidget(name: 'Total Late Minutes', title: '$totalLateMinutes'),
            rowWidget(name: 'Leaves (Paid)', title: '$leaveDays'),
            // rowWidget(name: 'Leaves (Unpaid)', title: '01'),
          ],
        ),
      ),
    );
  }

  Widget basicInformationWidget() {
    return Container(
      decoration:
          BoxDecoration(color: const Color(0xff7DC247).withOpacity(0.09)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: poppinSemiBold.copyWith(
                  fontSize: MySize.size14, color: primaryColor),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            rowWidget(name: 'Name', title: widget.employeData!['name']),
            rowWidget(name: 'Emp Type', title: widget.employeData!['type']),
            rowWidget(name: 'Rooster', title: '09 AM - 05 PM'),
            rowWidget(
                name: 'Account no', title: widget.employeData!['accountNo']),
            rowWidget(
                name: 'Bank Name', title: widget.employeData!['bankName']),
          ],
        ),
      ),
    );
  }

  Widget rowWidget({required String title, required String name}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size8),
      child: Padding(
        padding: EdgeInsets.only(bottom: MySize.size10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 5,
                child: Text(
                  name,
                  style: poppinMedium.copyWith(fontSize: MySize.size14),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: poppinMedium.copyWith(
                      fontSize: MySize.size12, color: lightGrey),
                )),
          ],
        ),
      ),
    );
  }
}
