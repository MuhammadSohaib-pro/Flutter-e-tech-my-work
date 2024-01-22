// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elabd_tms_app/components/custom_app_bar.dart';
// import 'package:elabd_tms_app/components/custom_button2.dart';
// import 'package:elabd_tms_app/components/custom_text.dart';
// import 'package:elabd_tms_app/components/loader.dart';
// import 'package:elabd_tms_app/constants/colors.dart';
// import 'package:elabd_tms_app/main.dart';
// import 'package:elabd_tms_app/models/attendance_report_model.dart';
// import 'package:elabd_tms_app/models/user_report.dart';
// import 'package:elabd_tms_app/services/user_report_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../models/select_index_controller.dart';
// import '../profile/bank_account_info.dart';
// class SalaryReportScreen extends StatefulWidget {
//   const SalaryReportScreen({Key? key}) : super(key: key);
//   @override
//   State<SalaryReportScreen> createState() => _SalaryReportScreenState();
// }
// class _SalaryReportScreenState extends State<SalaryReportScreen> {
//   List<int> years = [];
//   int? selectedYear;
//   List<String> months = [
//     'January',
//     'February',
//     'March',
//     'April',
//     'May',
//     'June',
//     'July',
//     'August',
//     'September',
//     'October',
//     'November',
//     'December',
//   ];
//   String? selectedMonth;
//   final selectIndexCtrl = Get.put(SelectIndexController());
//   UserReport? userData;
//   @override
//   void initState() {
//     super.initState();
//     DateTime currentDate = DateTime.now();
//     selectedMonth = DateFormat('MMMM').format(currentDate);
//     int currentYear = currentDate.year;
//     selectedYear = currentYear;
//     int startYear = 2010;
//     for (int year = currentYear; year >= startYear; year--) {
//       years.add(year);
//     }
//     getUserReport();
//     fetchUserData();
//   }
//   getUserReport() {
//     getIt<UserReportService>()
//         .getUserReport(selectedMonth!, selectedYear!)
//         .then((value) {
//       setState(() {
//         userData = value;
//       });
//     });
//   }
//   getAttendanceReport() {
//     if (userData != null) {
//       getIt<UserReportService>()
//           .getAttendanceReport(selectedMonth!, selectedYear!)
//           .then((value) {
//         setState(() {
//           userData!.attendanceReport = value ?? AttendanceReportModel();
//         });
//       });
//     }
//   }
//   Map<String, dynamic>? employeeData;
// // Inside your method or build function
//   void fetchUserData() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       DocumentSnapshot employeeSnapshot = await FirebaseFirestore.instance
//           .collection('employees')
//           .doc(user.uid)
//           .get();
//       if (employeeSnapshot.exists) {
//         setState(() {
//           employeeData = employeeSnapshot.data() as Map<String, dynamic>;
//         });
//       } else {
//         print('Employee data does not exist in Firestore.');
//       }
//     } else {
//       print('No user is currently logged in.');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return employeeData == null
//         ? Scaffold(body: Center(child: CircularProgressIndicator()))
//         : employeeData!['accountTitle'] == "" &&
//                 employeeData!['accountNo'] == "" &&
//                 employeeData!['iban'] == "" &&
//                 employeeData!['bankName'] == ""
//             ? Scaffold(
//                 body: SafeArea(
//                     child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BankAccountInfo()));
//                           },
//                           child: const Text(
//                               'Please First Fill the Account Information'))
//                     ],
//                   ),
//                 )),
//               )
//             : Scaffold(
//                 backgroundColor: Colors.white,
//                 appBar: CustomAppBar(
//                   leading: IconButton(
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.black,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   title: "Salary Report",
//                   textColor: Colors.black,
//                   backgroundColor: Colors.white,
//                   actions: [
//                     InkWell(
//                       onTap: () {
//                         dialogShow(context);
//                       },
//                       child: const Icon(
//                         Icons.print,
//                         color: primaryColor,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20.w,
//                     ),
//                   ],
//                 ),
//                 body: SafeArea(
//                   child: userData == null
//                       ? const Loader()
//                       : SingleChildScrollView(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 14.w, vertical: 16.h),
//                             child: Column(
//                               children: [
//                                 Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.only(
//                                             left: 10.w, right: 20.w),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(10).r,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.1),
//                                               spreadRadius: 5,
//                                               blurRadius: 7,
//                                               offset: const Offset(0, 3),
//                                             ),
//                                           ],
//                                         ),
//                                         child: DropdownButton<int>(
//                                           underline: Container(),
//                                           value: selectedYear,
//                                           // Set the selected year as the value
//                                           onChanged: (int? year) {
//                                             setState(() {
//                                               selectedYear = year;
//                                               getAttendanceReport();
//                                             });
//                                           },
//                                           items: [
//                                             const DropdownMenuItem<int>(
//                                               value:
//                                                   null, // Set the initial value to null
//                                               child: Text('Select Year'),
//                                             ),
//                                             ...years.map((int year) {
//                                               return DropdownMenuItem<int>(
//                                                 value: year,
//                                                 child: Text(
//                                                   year.toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 15.sp),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(
//                                             left: 10.w, right: 20.w),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.1),
//                                               spreadRadius: 5,
//                                               blurRadius: 7,
//                                               offset: const Offset(0, 3),
//                                             ),
//                                           ],
//                                         ),
//                                         child: DropdownButton<String>(
//                                           underline: Container(),
//                                           value: selectedMonth,
//                                           // Set the selected month as the value
//                                           onChanged: (String? month) {
//                                             setState(() {
//                                               selectedMonth = month;
//                                               getAttendanceReport();
//                                             });
//                                           },
//                                           items: [
//                                             const DropdownMenuItem<String>(
//                                               value:
//                                                   null, // Set the initial value to null
//                                               child: Text('Select Month'),
//                                             ),
//                                             ...months.map((String month) {
//                                               return DropdownMenuItem<String>(
//                                                 value: month,
//                                                 child: Text(month),
//                                               );
//                                             }).toList(),
//                                           ],
//                                         ),
//                                       ),
//                                     ]),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 basicInfoWidget(),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 attendenceInfoWidget(),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 deductionInfoWidget(),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 summaryWidget(),
//                               ],
//                             ),
//                           ),
//                         ),
//                 ),
//               );
//   }
//   Row _buildItemRow({required String title, required String value}) {
//     return Row(
//       children: [
//         Expanded(
//           child: CustomText(
//             text: title,
//             fontWeight: FontWeight.w500,
//             fontSize: 13.sp,
//             color: black,
//           ),
//         ),
//         Expanded(
//           child: CustomText(
//             text: value,
//             fontWeight: FontWeight.w700,
//             fontSize: 13.sp,
//             color: hideTextColor,
//           ),
//         ),
//       ],
//     );
//   }
//  Widget basicInfoWidget() {
//     return AppReportCard(title: "Basic Information", children: [
//       _buildItemRow(title: "Name", value: userData!.fullName),
//       SizedBox(height: 12.h),
//       _buildItemRow(title: "Emp Type", value: userData!.empType),
//       SizedBox(height: 12.h),
//       _buildItemRow(title: "Rooster", value: userData!.rooster),
//       SizedBox(height: 12.h),
//       _buildItemRow(
//           title: "Account No",
//           value: userData!.accNo
//               .replaceRange(2, userData!.accNo.length - 1, "***********")),
//       SizedBox(height: 12.h),
//       _buildItemRow(title: "Bank Name", value: userData!.bankName),
//     ]);
//   }
//   Widget attendenceInfoWidget() {
//     return AppReportCard(title: "Attendance Information", children: [
//       _buildItemRow(
//           title: "Presents",
//           value: userData!.attendanceReport.presents.toString()),
//       SizedBox(height: 12.h),
//       _buildItemRow(
//           title: "Absents",
//           value: userData!.attendanceReport.absents.toString()),
//       SizedBox(height: 12.h),
//       _buildItemRow(
//           title: "Late Minutes (Days)",
//           value: userData!.attendanceReport.lateMinutesInDays.toString()),
//       SizedBox(height: 12.h),
//       _buildItemRow(
//           title: "Total Late Minutes",
//           value: userData!.attendanceReport.totalLateMinutes.toString()),
//       SizedBox(height: 12.h),
//       _buildItemRow(
//           title: "Leaves (Paid)",
//           value: userData!.attendanceReport.paidLeaves.toString()),
//       SizedBox(height: 12.h),
//       _buildItemRow(
//           title: "Leaves (Unpaid)",
//           value: userData!.attendanceReport.unPaidLeaves.toString()),
//     ]);
//   }
//   Widget deductionInfoWidget() {
//     return Container(
//       padding: EdgeInsets.only(left: 10.w, right: 20.w, top: 10.h),
//       decoration: BoxDecoration(
//         color: const Color.fromRGBO(125, 194, 71, 0.09),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CustomText(
//                 text: "Deduction Information",
//                 fontWeight: FontWeight.w700,
//                 fontSize: 13,
//                 color: primaryColor,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomText(
//                   text: "Absents",
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13.sp,
//                   color: black,
//                 ),
//               ),
//               Expanded(
//                 child: CustomText(
//                   text: "2000/-",
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13.sp,
//                   color: hideTextColor,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 12.h,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomText(
//                   text: "Leaves(Unpaid)",
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13.sp,
//                   color: black,
//                 ),
//               ),
//               Expanded(
//                 child: CustomText(
//                   text: "1000/-",
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13.sp,
//                   color: hideTextColor,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomText(
//                   text: "Total Late Minutes",
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13.sp,
//                   color: black,
//                 ),
//               ),
//               Expanded(
//                 child: CustomText(
//                   text: "2500/-",
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13.sp,
//                   color: hideTextColor,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//         ],
//       ),
//     );
//   }
//   Widget summaryWidget() {
//     return AppReportCard(title: "Summary", children: [
//       _buildItemRow(title: "Basic Salary", value: userData!.basicSalary),
//       SizedBox(height: 12.h),
//       _buildItemRow(title: "Total Deduction", value: "----"),
//       SizedBox(height: 12.h),
//       _buildItemRow(title: "Salary Payable", value: "----")
//     ]);
//   }
//   void dialogShow(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) => Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: SizedBox(
//                 height: 260.h,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: IconButton(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.print,
//                               color: primaryColor,
//                             )),
//                       ),
//                       CustomText(
//                         text: "Download Now",
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.w500,
//                         color: black,
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomText(
//                         text: "Salary Report is being downloading...",
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w400,
//                         color: black,
//                       ),
//                       SizedBox(
//                         height: 40.h,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CustomButton2(
//                               icon:
//                                   const Icon(Icons.print, color: Colors.white),
//                               width: 150.w,
//                               height: 45.h,
//                               textColor: Colors.white,
//                               text: "Download",
//                               color: primaryColor,
//                               onPressed: () {}),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//   }
// }
// class AppReportCard extends StatelessWidget {
//   const AppReportCard({super.key, required this.title, required this.children});
//   final String title;
//   final List<Widget> children;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 10.w, right: 20.w, top: 10.h),
//       decoration: BoxDecoration(
//         color: const Color.fromRGBO(125, 194, 71, 0.09),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CustomText(
//                 text: title,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 13,
//                 color: primaryColor,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 12.h,
//           ),
//           ...children,
//           SizedBox(
//             height: 12.h,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/custom_app_bar.dart';
import 'package:elabd_tms_app/components/loader.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../profile/bank_account_info.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class SalaryReportScreen extends StatefulWidget {
  final Map<String, dynamic>? employeeData;
  const SalaryReportScreen({Key? key, this.employeeData}) : super(key: key);

  @override
  State<SalaryReportScreen> createState() => _SalaryReportScreenState();
}

class _SalaryReportScreenState extends State<SalaryReportScreen> {
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
    updateBankDetailOnPageLoad();
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

  Future<void> updateBankDetailOnPageLoad() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('employees')
          .where(
            'id',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid,
          )
          .get();

      for (final doc in querySnapshot.docs) {
        widget.employeeData?['accountTitle'] = doc['accountTitle'];
        widget.employeeData?['accountNo'] = doc['accountNo'];
        widget.employeeData?['iban'] = doc['iban'];
        widget.employeeData?['bankName'] = doc['bankName'];

        print("Acclunt title is --- ${widget.employeeData?['accountTitle']}");
        // print("Acclunt title is --- ${widget.employeeData?['accountNo']}");
        // print("Acclunt title is --- ${widget.employeeData?['iban']}");
        // print("Acclunt title is --- ${widget.employeeData?['bankName']}");
      }

      setState(() {});
    } catch (e) {
      print('Error  Why $e');
    }
  }

  Future<void> calculateAttendance() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('checkInOut')
          .where(
            'currentUserId',
            isEqualTo: widget.employeeData!['id'],
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
              .where('currentUserId', isEqualTo: widget.employeeData!['id'])
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
        String salaryString = widget.employeeData!['salary'];
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
              .where('currentUserId', isEqualTo: widget.employeeData!['id'])
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
                  'Name: ${widget.employeeData!['name']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Employee Type: ${widget.employeeData!['type']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Roster: 9 to 5',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Email: ${widget.employeeData!['email']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Bank Name: ${widget.employeeData!['bankName']}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Account Number: ${widget.employeeData!['accountNo']}',
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
      DateTime endDateTime = startDateTime
          .add(const Duration(days: 32))
          .subtract(const Duration(seconds: 1));

      startOfMonth = startDateTime.millisecondsSinceEpoch ~/ 1000;
      endOfMonth = endDateTime.millisecondsSinceEpoch ~/ 1000;

      // Use startOfMonth and endOfMonth in your Firestore query
      print("Start of month: $startOfMonth");
      print("End of month: $endOfMonth");
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.employeeData == null
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : widget.employeeData!['accountTitle'] == "" ||
                widget.employeeData!['accountNo'] == "" ||
                widget.employeeData!['iban'] == "" ||
                widget.employeeData!['bankName'] == ""
            ? Scaffold(
                body: SafeArea(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BankAccountInfo()));
                          },
                          child: const Text(
                              'Please First Fill the Account Information'))
                    ],
                  ),
                )),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: CustomAppBar(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: "Salary Report",
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  actions: [
                    InkWell(
                      onTap: () {
                        generateAndShowPDF(documentList);
                      },
                      child: const Icon(
                        Icons.print,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
                body: SafeArea(
                    child: widget.employeeData == null
                        ? const Loader()
                        : SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                                              selectedMonth =
                                                  month; // Update the selected month
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
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                                              selectedYear =
                                                  year; // Update the selected year
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

                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Current Status: ',
                                        style: TextStyle(
                                            fontSize: 12, color: primaryColor),
                                      ),
                                      Text(
                                        // ' Paid',
                                        widget.employeeData!['salaryStatus'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: widget.employeeData![
                                                        'salaryStatus'] ==
                                                    'UnPaid'
                                                ? redColor
                                                : primaryColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  StreamBuilder(
                                      stream: _firestore
                                          .collection('checkInOut')
                                          .where('currentUserId',
                                              isEqualTo:
                                                  widget.employeeData!['id'])
                                          .where('unixTimestamp',
                                              isGreaterThanOrEqualTo:
                                                  startOfMonth)
                                          .where('unixTimestamp',
                                              isLessThan: endOfMonth)
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Center(
                                              child: Text('No Data Found'));
                                        } else if (snapshot.data.docs.isEmpty) {
                                          return const Center(
                                              child: Text('No Data found'));
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              basicInformationWidget(),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              attendanceInformationWidget(),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              deductionInformationWidget(),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              summaryWidget(),
                                            ],
                                          );
                                        }
                                      }),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          )));
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
            const Text(
              'Summary',
              style: TextStyle(fontSize: 14, color: primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            rowWidget(
                name: 'Basic Salary',
                title: '${widget.employeeData!['salary']}/-'),
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
            const Text(
              'Deduction  Information',
              style: TextStyle(fontSize: 14, color: primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            rowWidget(
                name: 'Absents',
                title: '${absentDeduction.toStringAsFixed(0)}/-'),
            // rowWidget(name: 'Leaves (Unpaid)', title: '2000/-'),
            rowWidget(name: 'Total Late Minutes', title: '$totalLateMinutes/-'),
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
            const Text(
              'Attendance  Information',
              style: TextStyle(fontSize: 14, color: primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            rowWidget(name: 'Present', title: '$presentDays'),
            rowWidget(name: 'Absents', title: '$absentDays'),
            // rowWidget(name: 'Late Minutes (Days)', title: '02'),
            rowWidget(name: 'Total Late Minutes', title: '$totalLateMinutes'),
            rowWidget(name: 'Leaves (Paid)', title: '01'),
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
            const Text(
              'Basic Information',
              style: TextStyle(fontSize: 14, color: primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            rowWidget(name: 'Name', title: widget.employeeData!['name']),
            rowWidget(name: 'Emp Type', title: widget.employeeData!['type']),
            rowWidget(name: 'Rooster', title: '09 AM - 05 PM'),
            rowWidget(
                name: 'Account no', title: widget.employeeData!['accountNo']),
            rowWidget(
                name: 'Bank Name', title: widget.employeeData!['bankName']),
          ],
        ),
      ),
    );
  }

  Widget rowWidget({required String title, required String name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 5,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 14),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )),
          ],
        ),
      ),
    );
  }
}
