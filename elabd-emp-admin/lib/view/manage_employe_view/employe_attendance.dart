import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/routes/routes_const.dart';
import 'package:elabd_ems_admin/services/internet_check.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../manage_task_view/components/button_comp.dart';

class EmployeAttendance extends StatefulWidget {
  final String? receiveId;
  final String? receiveName;
  final String? currentUserId;
  const EmployeAttendance(
      {super.key, this.receiveId, this.receiveName, this.currentUserId});

  @override
  State<EmployeAttendance> createState() => _EmployeAttendanceState();
}

class _EmployeAttendanceState extends State<EmployeAttendance> {
  final selectDateController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutCotroller = TextEditingController();
  final yearController = TextEditingController();
  final monthController = TextEditingController();

  String formatDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('EE'); // Customize the date format
    return formatter.format(dateTime);
  }

  String formateDateDay(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('d'); // Customize the date format
    return formatter.format(dateTime);
  }

  List<QueryDocumentSnapshot> documentList = [];

  // //selection of month year
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
  @override
  void initState() {
    super.initState();
    //selection of month year
    int currentYear = DateTime.now().year;
    int startYear = 2001;
    for (int year = currentYear; year >= startYear; year--) {
      years.add(year);
    }
    selectedYear = currentYear;
    selectedMonth = DateFormat('MMMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    debugPrint(widget.receiveName);
    debugPrint(widget.receiveId);
    debugPrint('this is current user id');
    debugPrint(widget.currentUserId);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size16),
        child: Column(
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
                    attendenceReportDiaog(context);
                  },
                  child: Image.asset(
                    AppIcons.download,
                    height: MySize.size14,
                    width: MySize.size14,
                  ),
                ),
              ],
            ),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('checkInOut')
                  .where('currentUserId', isEqualTo: widget.currentUserId)
                  .where('unixTimestamp', isGreaterThanOrEqualTo: startOfMonth)
                  .where('unixTimestamp', isLessThan: endOfMonth)
                  .orderBy('unixTimestamp')
                  .snapshots(),
              // this is simple query
              // FirebaseFirestore.instance
              //     .collection('checkInOut')
              //     .where('currentUserId', isEqualTo: widget.currentUserId)
              //     .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  return const Text('No data found ');
                } else if (snapshot.data.docs.isEmpty) {
                  return const Text('No data found of the current user');
                } else if (snapshot.hasError) {
                  return Text('Error ${snapshot.hasError}');
                } else {
                  documentList =
                      snapshot.data.docs; // List of QueryDocumentSnapshot
                  return Column(
                    children: [
                      SizedBox(
                        height: MySize.size30,
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: MySize.size15,
                        ),
                        itemBuilder: (context, index) {
                          dutyDuration =
                              documentList[index]['checkOutTime'] == ''
                                  ? '0 hours 0 minuts'
                                  : calculateDutyDuration(
                                      documentList[index]['checkInTime'],
                                      documentList[index]['checkOutTime']);
                          bool absent = documentList[index]['isAbsent'];
                          bool leave = documentList[index]['isLeave'];
                          return absent
                              ? GestureDetector(
                                  onTap: () {
                                    editEmployeStatusDialog(
                                      date: documentList[index]['date'],
                                      isAbsent: documentList[index]['isAbsent'],
                                      isLeave: false,
                                      isPresent: false,
                                      checkInTime: documentList[index]
                                          ['checkInTime'],
                                      checkOutTime: documentList[index]
                                          ['checkOutTime'],
                                    );
                                  },
                                  child: leaveAbsentWidget(
                                      title: 'Absent',
                                      color: redColor,
                                      index: index,
                                      documentList: documentList),
                                )
                              : leave
                                  ? GestureDetector(
                                      onTap: () {
                                        editEmployeStatusDialog(
                                          date: documentList[index]['date'],
                                          isLeave: documentList[index]
                                              ['isLeave'],
                                          isAbsent: false,
                                          isPresent: false,
                                          checkInTime: documentList[index]
                                              ['checkInTime'],
                                          checkOutTime: documentList[index]
                                              ['checkOutTime'],
                                        );
                                      },
                                      child: leaveAbsentWidget(
                                          title: 'Leave',
                                          color: primaryColor,
                                          index: index,
                                          documentList: documentList),
                                    )
                                  : presentWidget(context, index, documentList);
                        },
                        itemCount: documentList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      SizedBox(height: MySize.size15),
                    ],
                  );
                }
              },
            )

            // StreamBuilder<QuerySnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection('checkInOut')
            //       .where('currentUserId', isEqualTo: widget.currentUserId)
            //       .snapshots(),
            //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (!snapshot.hasData) {
            //       return const Text('No data found');
            //     } else {
            //       List<QueryDocumentSnapshot> documentList = snapshot.data!.docs
            //           .toList(); // List of QueryDocumentSnapshot
            //       return StreamBuilder<QuerySnapshot>(
            //         stream: FirebaseFirestore.instance
            //             .collection('notifications')
            //             .snapshots(),
            //         builder: (context,
            //             AsyncSnapshot<QuerySnapshot> notificationSnapshot) {
            //           if (notificationSnapshot.connectionState ==
            //               ConnectionState.waiting) {
            //             return const Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           } else if (!notificationSnapshot.hasData) {
            //             return const Text('No notification data found');
            //           } else {
            //             List<Map<String, dynamic>> notificationsData =
            //                 notificationSnapshot.data!.docs
            //                     .map(
            //                         (doc) => doc.data() as Map<String, dynamic>)
            //                     .toList();
            //             return Column(
            //               children: [
            //                 SizedBox(
            //                   height: MySize.size30,
            //                 ),
            //                 ListView.separated(
            //                   separatorBuilder: (context, index) => SizedBox(
            //                     height: MySize.size15,
            //                   ),
            //                   itemBuilder: (context, index) {
            //                     final userId =
            //                         documentList[index]['currentUserId'];
            //                     // Find the corresponding notification data for this user
            //                     final notification =
            //                         notificationsData.firstWhere(
            //                       (data) => data['id'] == userId,
            //                       orElse: () => null!,
            //                     );
            //                     if (notification != null) {
            //                       final status = notification['status'];
            //                       if (status == 'Accepted') {
            //                         return leaveAbsentWidget(
            //                             title: 'Leave', color: primaryColor,index, documentList);
            //                       } else if (status == 'Rejected') {
            //                         return leaveAbsentWidget(
            //                             title: 'Absent', color: redColor,index, documentList);
            //                       }
            //                     }
            //                     // If no matching notification or the status is different,
            //                     // show AbsentWidget
            //                     return presentWidget(
            //                         context, index, documentList);
            //                   },
            //                   itemCount: documentList.length,
            //                   shrinkWrap: true,
            //                   physics: const NeverScrollableScrollPhysics(),
            //                 ),
            //               ],
            //             );
            //           }
            //         },
            //       );
            //     }
            //   },
            // )

            // StreamBuilder<QuerySnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection('checkInOut')
            //       .where('currentUserId', isEqualTo: widget.currentUserId)
            //       .snapshots(),
            //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //       return const Text('No data found');
            //     } else {
            //       List<QueryDocumentSnapshot> documentList = snapshot.data!.docs
            //           .toList(); // List of QueryDocumentSnapshot
            //       return StreamBuilder<QuerySnapshot>(
            //         stream: FirebaseFirestore.instance
            //             .collection('notifications')
            //             .snapshots(),
            //         builder: (context,
            //             AsyncSnapshot<QuerySnapshot> notificationSnapshot) {
            //           if (notificationSnapshot.connectionState ==
            //               ConnectionState.waiting) {
            //             return const Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           } else if (!notificationSnapshot.hasData) {
            //             return const Text('No notification data found');
            //           } else {
            //             List<Map<String, dynamic>> notificationsData =
            //                 notificationSnapshot.data!.docs
            //                     .map(
            //                         (doc) => doc.data() as Map<String, dynamic>)
            //                     .toList();
            //             return Column(
            //               children: [
            //                 SizedBox(
            //                   height: MySize.size30,
            //                 ),
            //                 ListView.separated(
            //                   separatorBuilder: (context, index) => SizedBox(
            //                     height: MySize.size15,
            //                   ),
            //                   itemBuilder: (context, index) {
            //                     final userId =
            //                         documentList[index]['currentUserId'];
            //                     // Find the corresponding notification data for this user
            //                     final notification =
            //                         notificationsData.firstWhere(
            //                       (data) => data['id'] == userId,
            //                       orElse: () => null!,
            //                     );
            //                     if (notification != null) {
            //                       final status = notification['status'];
            //                       if (status == 'Accepted') {
            //                         return leaveAbsentWidget(
            //                             documentList: documentList,
            //                             index: index,
            //                             title: 'Leave',
            //                             color: primaryColor);
            //                       } else if (status == 'Rejected') {
            //                         return leaveAbsentWidget(
            //                             documentList: documentList,
            //                             index: index,
            //                             title: 'Absent',
            //                             color: redColor);
            //                       }
            //                     }
            //                     // If no matching notification or the status is different,
            //                     // show PresentWidget
            //                     return presentWidget(
            //                         context, index, documentList);
            //                   },
            //                   itemCount: documentList.length,
            //                   shrinkWrap: true,
            //                   physics: const NeverScrollableScrollPhysics(),
            //                 ),
            //               ],
            //             );
            //           }
            //         },
            //       );
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
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

  // Future<void> generateAndShowPDF(
  //     List<Map<String, dynamic>> documentList) async {
  //   // Fetch data from the "notifications" collection
  //   final notificationsQuerySnapshot =
  //       await FirebaseFirestore.instance.collection('notifications').get();
  //   final notificationsData =
  //       notificationsQuerySnapshot.docs.map((doc) => doc.data()).toList();
  //   // Merge notifications data with existing documentList
  //   for (int i = 0; i < documentList.length; i++) {
  //     final userId = documentList[i]['userId'];
  //     final notification = notificationsData
  //         .firstWhere((data) => data['userId'] == userId, orElse: () {
  //       return null!;
  //     });
  //     if (notification != null) {
  //       final status = notification['status'];
  //       documentList[i]['status'] = status;
  //     }
  //   }
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.ListView.builder(
  //             itemCount: documentList.length,
  //             itemBuilder: (pw.Context context, int index) {
  //               final status = documentList[index]['status'];
  //               final checkInTime = status == 'accepted'
  //                   ? 'Leave'
  //                   : 'Check-In: ${documentList[index]['checkInTime'] ?? 'N/A'}';
  //               final checkOutTime = status == 'rejected'
  //                   ? 'Absent'
  //                   : 'Check-Out: ${documentList[index]['checkOutTime'] ?? 'N/A'}';
  //               return pw.Text('$checkInTime, $checkOutTime');
  //             },
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   final Uint8List pdfBytes = await pdf.save();
  //   final output = await getTemporaryDirectory();
  //   final file = File('${output.path}/example.pdf');
  //   await file.writeAsBytes(pdfBytes);
  //   OpenFile.open(file.path, type: 'application/pdf');
  // }

  // Future<void> generateAndShowPDF(
  //     List<QueryDocumentSnapshot> documentList) async {
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.ListView.builder(
  //             itemCount: documentList.length,
  //             itemBuilder: (pw.Context context, int index) {
  //               return pw.ListView.builder(
  //                 itemCount: documentList.length,
  //                 itemBuilder: (pw.Context context, int index) {
  //                   // final checkInTime =
  //                   //     documentList[index]['checkInTime'] ?? 'N/A';
  //                   // final checkOutTime =
  //                   //     documentList[index]['checkOutTime'] ?? 'N/A';
  //                   return pw.Column(children: [
  //                     pw.Text(documentList[index]['checkInTime']),
  //                     pw.Text(documentList[index]['checkOutTime']),
  //                   ]);
  //                 },
  //               );
  //             },
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   final Uint8List pdfBytes = await pdf.save();
  //   final output = await getTemporaryDirectory();
  //   final file = File('${output.path}/example.pdf');
  //   await file.writeAsBytes(pdfBytes);
  //   OpenFile.open(file.path, type: 'application/pdf');
  // }

  Future<void> generateAndShowPDF(
      List<QueryDocumentSnapshot> documentList) async {
    final pdf = pw.Document();

    // Sort the documentList by the date field in ascending order
    documentList.sort((a, b) => a['date'].compareTo(b['date']));
    // Fetch data from the "notifications" collection
    final notificationsQuerySnapshot =
        await FirebaseFirestore.instance.collection('notifications').get();

    final notificationsData =
        notificationsQuerySnapshot.docs.map((doc) => doc.data()).toList();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Table(
              columnWidths: {
                0: pw.IntrinsicColumnWidth(),
                1: pw.IntrinsicColumnWidth(),
                2: pw.IntrinsicColumnWidth(),
              },
              border: pw.TableBorder.all(),
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                // Table headers
                pw.TableRow(
                  children: [
                    pw.Text('Serial Number'),
                    pw.Text('Check-In Time'),
                    pw.Text('Check-Out Time'),
                    pw.Text('Date'),
                    pw.Text('Status'),
                  ],
                ),

                // Table rows
                for (int index = 0; index < documentList.length; index++)
                  pw.TableRow(
                    children: [
                      pw.Text('${index + 1}'),
                      pw.Text(documentList[index]['checkInTime'] ?? 'N/A'),
                      pw.Text(documentList[index]['checkOutTime'] ?? 'N/A'),
                      pw.Text(documentList[index]['date'] ?? 'N/A'),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );

    final Uint8List pdfBytes = await pdf.save();
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/example.pdf');
    await file.writeAsBytes(pdfBytes);

    OpenFile.open(file.path, type: 'application/pdf');
  }

  String? dutyDuration;
  void attendenceReportDiaog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size12),
              ),
              child: Padding(
                padding: EdgeInsets.all(MySize.size16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.print,
                            color: primaryColor,
                          )),
                    ),
                    Text(
                      'Download Now',
                      style: TextStyle(
                        fontSize: MySize.size24,
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    SizedBox(height: MySize.size10),
                    Text(
                      "Attendence Report is being downloading...",
                      style: TextStyle(
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ),
                    SizedBox(
                      height: MySize.size40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonComp(
                            textColor: Colors.white,
                            title: "Download",
                            backColor: primaryColor,
                            onTap: () {
                              generateAndShowPDF(documentList);
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  String calculateDutyDuration(String checkInTime, String checkOutTime) {
    List<String> checkInParts = checkInTime.split(':');
    List<String> checkOutParts = checkOutTime.split(':');

    int checkInHour = int.parse(checkInParts[0]);
    int checkInMinute = int.parse(checkInParts[1]);

    int checkOutHour = int.parse(checkOutParts[0]);
    int checkOutMinute = int.parse(checkOutParts[1]);

    // Calculate the difference in hours and minutes
    int totalMinutes =
        (checkOutHour - checkInHour) * 60 + (checkOutMinute - checkInMinute);

    // Calculate hours and minutes from the total minutes
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    // Format the result
    String formattedDuration = '$hours hours $minutes minutes';
    return formattedDuration;
  }

  Widget presentWidget(BuildContext context, int index,
      List<QueryDocumentSnapshot> documentList) {
    final dateString = documentList[index]['date'];
    final formattedDate = formatDate(dateString);
    final dayString = documentList[index]['date'];
    final formateDay = formateDateDay(dayString);
    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(MySize.size10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(2, 2),
              color: blackColor.withOpacity(0.10),
            )
          ]),
      child: ExpansionTileCard(
        contentPadding: const EdgeInsets.all(0),
        baseColor: whiteColor,
        title: const Text(''),
        subtitle: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(MySize.size10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(1, 1),
                              color: blackColor.withOpacity(0.20))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MySize.size0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formattedDate,
                              // 'Wed',
                              style: poppineRegular.copyWith(
                                  color: primaryColor, fontSize: MySize.size10),
                            ),
                            Text(
                              formateDay,
                              style:
                                  poppinBold.copyWith(fontSize: MySize.size12),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MySize.size30,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Check in',
                  style: poppinBold.copyWith(fontSize: MySize.size18),
                ),
                Text(
                  documentList[index]['checkInTime'],
                  style: poppinMedium.copyWith(fontSize: MySize.size16),
                ),
                Row(
                  children: [
                    Image.asset(
                      AppIcons.location2,
                      height: MySize.size10,
                      width: MySize.size10,
                    ),
                    Text(
                      'Islamabad i-10',
                      style: poppineRegular.copyWith(
                          fontSize: MySize.size8, color: primaryColor),
                    ),
                  ],
                )
              ]),
              VerticalDivider(
                thickness: 1,
                indent: MySize.size16,
                endIndent: MySize.size34,
                color: const Color(0xffE9E9E9),
              ),
              SizedBox(
                width: MySize.size20,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Check Out',
                  style: poppinBold.copyWith(fontSize: MySize.size18),
                ),
                Text(
                  documentList[index]['checkOutTime'] == ""
                      ? 'No checkout'
                      : documentList[index]['checkOutTime'],
                  style: poppinMedium.copyWith(
                      fontSize: documentList[index]['checkOutTime'] == ""
                          ? MySize.size12
                          : MySize.size16,
                      color: documentList[index]['checkOutTime'] == ""
                          ? redColor
                          : null),
                ),
                Row(
                  children: [
                    Image.asset(
                      AppIcons.location2,
                      height: MySize.size10,
                      width: MySize.size10,
                    ),
                    Text(
                      'Islamabad i-10',
                      style: poppineRegular.copyWith(
                          fontSize: MySize.size8, color: primaryColor),
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                width: 50,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Today Duty Duration: ',
                          style: poppineRegular.copyWith(
                              fontSize: MySize.size10, color: lightGrey),
                          children: [
                            TextSpan(
                                text: dutyDuration,
                                style: poppinBold.copyWith(
                                    fontSize: MySize.size12,
                                    color: primaryColor)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      SizedBox(
                        width: MySize.screenWidth * 0.6,
                        height: MySize.size35,
                        child: ButtonWidget(
                          title: 'Edit',
                          textColor: whiteColor,
                          fontSize: MySize.size10,
                          ontap: () {
                            editEmployeStatusDialog(
                              date: documentList[index]['date'],
                              isPresent: documentList[index]['isPresent'],
                              isLeave: false,
                              isAbsent: false,
                              checkInTime: documentList[index]['checkInTime'],
                              checkOutTime: documentList[index]['checkOutTime'],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  Future<void> checkOutTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != TimeOfDay.now()) {
      final String formattedTime = _formatTime(picked);
      print('Selected time: $formattedTime');
      // Do something with the selected time
      checkOutCotroller.text = formattedTime;
    }
  }

  Future<void> checkInTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != TimeOfDay.now()) {
      final String formattedTime = _formatTime(picked);
      print('Selected time: $formattedTime');
      // Do something with the selected time
      checkInController.text = formattedTime;
    }
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final int hour = timeOfDay.hour;
    final int minute = timeOfDay.minute;

    // Formatting hours and minutes to have leading zeroes if needed
    final String formattedHour = hour.toString().padLeft(2, '0');
    final String formattedMinute = minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute';
  }

  int selectedValue = -1;

  Future<void> editEmployeStatusDialog({
    required String date,
    required String checkInTime,
    required String checkOutTime,
    required bool isPresent,
    required bool isAbsent,
    required bool isLeave,
  }) async {
    checkInController.text = checkInTime;
    checkOutCotroller.text = checkOutTime;
    int initialSelectedValue = 0;
    if (isPresent) {
      initialSelectedValue = 1;
    } else if (isAbsent) {
      initialSelectedValue = 0;
    } else {
      initialSelectedValue = 2;
    }
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(child: StatefulBuilder(builder: (context, setState) {
            selectedValue = initialSelectedValue;
            return SingleChildScrollView(
              child: Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: whiteColor),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Select date',
                              style: poppinMedium.copyWith(
                                  fontSize: MySize.size10),
                            ),
                            SizedBox(
                              height: MySize.size12,
                            ),
                            TextFieldWidget(
                                isDense: true,
                                verticalPadding: 10,
                                readOnly: true,
                                // sufixIcon: Padding(
                                //   padding: const EdgeInsets.all(18),
                                //   child: Image.asset(
                                //     AppIcons.calander,
                                //     height: MySize.size10,
                                //     width: MySize.size10,
                                //   ),
                                // ),
                                controller: selectDateController,
                                hintText: date),
                            SizedBox(
                              height: MySize.size20,
                            ),
                            selectedValue == 0 || selectedValue == 2
                                ? const SizedBox(
                                    height: 0,
                                    width: 0,
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Check in',
                                            style: poppinMedium.copyWith(
                                                fontSize: MySize.size12),
                                          ),
                                          TextFieldWidget(
                                              readOnly: true,
                                              isDense: true,
                                              horizontalPadding: 10,
                                              verticalPadding: 10,
                                              sufixIcon: InkWell(
                                                  onTap: () {
                                                    checkInTimePicker(context);
                                                  },
                                                  child: const Icon(
                                                    Icons.calendar_month,
                                                  )),
                                              controller: checkInController,
                                              hintText: checkInTime)
                                        ],
                                      )),
                                      SizedBox(
                                        width: MySize.size10,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Check out',
                                            style: poppinMedium.copyWith(
                                                fontSize: MySize.size12),
                                          ),
                                          TextFieldWidget(
                                              isDense: true,
                                              readOnly: true,
                                              horizontalPadding: 10,
                                              verticalPadding: 10,
                                              sufixIcon: InkWell(
                                                  onTap: () {
                                                    checkOutTimePicker(context);
                                                  },
                                                  child: const Icon(
                                                      Icons.calendar_month)),
                                              controller: checkOutCotroller,
                                              hintText: checkOutTime)
                                        ],
                                      ))
                                    ],
                                  ),
                            SizedBox(
                              height: MySize.size20,
                            ),
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        //   child: RadioListTile<int>(
                        //     contentPadding: EdgeInsets.zero,
                        //     dense: true,
                        //     title: const Text(
                        //       'Absent',
                        //       style: poppinMedium,
                        //     ),
                        //     value: 1,
                        //     groupValue: selectedValue,
                        //     onChanged: (int? value) {
                        //       setState(() {
                        //         selectedValue = value!;
                        //         print(value);
                        //       });
                        //     },
                        //   ),
                        // ),
                        // Expanded(
                        //   child: RadioListTile<int>(
                        //     contentPadding: EdgeInsets.zero,
                        //     dense: true,
                        //     title: const Text(
                        //       'Leave',
                        //       style: poppinMedium,
                        //     ),
                        //     value: 2,
                        //     groupValue: selectedValue,
                        //     onChanged: (int? value) {
                        //       setState(() {
                        //         selectedValue = value!;
                        //         print(value);
                        //       });
                        //     },
                        //   ),
                        // ),
                        // Expanded(
                        //   child: RadioListTile<int>(
                        //     contentPadding: EdgeInsets.zero,
                        //     dense: true,
                        //     title: const Text(
                        //       'Present',
                        //       style: poppinMedium,
                        //     ),
                        //     value: 3,
                        //     groupValue: selectedValue,
                        //     onChanged: (int? value) {
                        //       setState(() {
                        //         selectedValue = value!;
                        //         print(value);
                        //       });
                        //     },
                        //   ),
                        // ),
                        Row(
                          children: [
                            Radio(
                                value: 0,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    initialSelectedValue = value!;
                                    print(value);
                                  });
                                }),
                            Text(
                              'Absent',
                              style: poppineRegular.copyWith(
                                  fontSize: MySize.size12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    initialSelectedValue = value!;

                                    print(value);
                                  });
                                }),
                            Text(
                              'Present',
                              style: poppineRegular.copyWith(
                                  fontSize: MySize.size12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 2,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    initialSelectedValue = value!;
                                    print(value);
                                  });
                                }),
                            Text(
                              'Leave',
                              style: poppineRegular.copyWith(
                                  fontSize: MySize.size12),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () async {
                              bool isInternetConnect =
                                  await checkInternetConnection();
                              if (isInternetConnect) {
                                FirebaseFirestore.instance
                                    .collection('checkInOut')
                                    .where('currentUserId',
                                        isEqualTo: widget.currentUserId)
                                    .where('date', isEqualTo: date)
                                    .get()
                                    .then((QuerySnapshot<Map<String, dynamic>>
                                        querySnapshot) {
                                  querySnapshot.docs.forEach(
                                      (QueryDocumentSnapshot<
                                              Map<String, dynamic>>
                                          doc) {
                                    // Get the document ID to use for updating the document
                                    String documentId = doc.id;

                                    // Update the fields you want here

                                    Map<String, dynamic> newData = {};
                                    if (selectedValue == 0) {
                                      newData = {
                                        'checkInTime': '00:00',
                                        'checkOutTime': '00:00',
                                        'isPresent': false,
                                        'isAbsent': true,
                                        'isLeave': false,
                                      };
                                    } else if (selectedValue == 2) {
                                      newData = {
                                        'checkInTime': '00:00',
                                        'checkOutTime': '00:00',
                                        'isPresent': false,
                                        'isAbsent': false,
                                        'isLeave': true,
                                      };
                                    } else {
                                      newData = {
                                        'checkInTime':
                                            checkInController.text.toString(),
                                        'checkOutTime':
                                            checkOutCotroller.text.toString(),
                                        'isPresent': true,
                                        'isAbsent': false,
                                        'isLeave': false,
                                      };
                                    }

                                    // if (checkInController.text.isEmpty &&
                                    //     checkOutCotroller.text.isEmpty) {
                                    //   // Both controller values are not empty
                                    //   if (selectedValue == 1) {
                                    //     newData = {
                                    //       'checkInTime': '00:00',
                                    //       'checkOutTime': '00:00',
                                    //       'isPresent': false,
                                    //       'isAbsent': true,
                                    //       'isLeave': false,
                                    //     };
                                    //     Navigator.pop(context);
                                    //   } else if (selectedValue == 2) {
                                    //     newData = {
                                    //       'checkInTime': '00:00',
                                    //       'checkOutTime': '00:00',
                                    //       'isPresent': false,
                                    //       'isAbsent': false,
                                    //       'isLeave': true,
                                    //     };
                                    //     Navigator.pop(context);
                                    //   }
                                    // } else if (checkInController
                                    //     .text.isNotEmpty) {
                                    //   newData = {
                                    //     'checkInTime':
                                    //         checkInController.text.toString(),
                                    //     'checkOutTime': checkOutTime,
                                    //     'isPresent': true,
                                    //   };
                                    //   Navigator.pop(context);
                                    // } else if (checkOutCotroller
                                    //     .text.isNotEmpty) {
                                    //   newData = {
                                    //     'checkInTime': checkInTime,
                                    //     'checkOutTime':
                                    //         checkOutCotroller.text.toString(),
                                    //     'isPresent': true,
                                    //   };
                                    //   Navigator.pop(context);
                                    // } else if (checkInController
                                    //         .text.isNotEmpty &&
                                    //     checkOutCotroller.text.isNotEmpty) {
                                    //   newData = {
                                    //     'checkInTime':
                                    //         checkInController.text.toString(),
                                    //     'checkOutTime':
                                    //         checkOutCotroller.text.toString(),
                                    //     'isPresent': true,
                                    //   };
                                    //   Navigator.pop(context);
                                    // } else {
                                    //   print('SomeThing wrong');
                                    // }

                                    // Update the document
                                    FirebaseFirestore.instance
                                        .collection('checkInOut')
                                        .doc(documentId)
                                        .update(newData)
                                        .then((_) {
                                      print('Document updated successfully');
                                      Navigator.pop(context);
                                    }).catchError((error) {
                                      print('Error updating document: $error');
                                    });
                                  });
                                }).catchError((error) {
                                  print('Error getting documents: $error');
                                });
                              } else {
                                showNoInternetDialog(context);
                              }
                            },
                            child: const Text('Update')),
                      ],
                    )
                  ],
                ),
              ),
            );
          }));
        });
  }

  Widget leaveAbsentWidget(
      {required String title,
      required Color color,
      required int index,
      required List<QueryDocumentSnapshot> documentList}) {
    final dateString = documentList[index]['date'];
    final formattedDate = formatDate(dateString);
    final dayString = documentList[index]['date'];
    final formateDay = formateDateDay(dayString);
    return Container(
      height: MySize.scaleFactorHeight * 78,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(MySize.size10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(2, 2),
              color: blackColor.withOpacity(0.10),
            )
          ]),
      child: Padding(
        padding: EdgeInsets.all(MySize.size5),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(2, 2),
                      color: blackColor.withOpacity(0.10),
                    )
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(MySize.size10)),
              child: Padding(
                padding: EdgeInsets.all(MySize.size10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formateDay,
                      style: poppineRegular.copyWith(fontSize: MySize.size10),
                    ),
                    Text(
                      formattedDate,
                      style: poppinBold.copyWith(fontSize: MySize.size12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Center(
                  child: Text(
                title,
                style: poppinBold.copyWith(color: color),
              )))
        ]),
      ),
    );
  }
}
