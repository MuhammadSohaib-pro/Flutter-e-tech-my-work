// import 'dart:developer';
//
// import 'package:elabd_tms_app/models/pdf_atttendance_model.dart';
// import 'package:elabd_tms_app/pdf_handler/pdf_config.dart';
// import 'package:elabd_tms_app/screens/home/home_screen_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../../components/custom_app_bar.dart';
// import '../../components/custom_button.dart';
// import '../../components/custom_text.dart';
// import '../../constants/colors.dart';
// import 'attendence_screen_provider.dart';
//
// enum TimeType {
//   // ignore: constant_identifier_names
//   CheckIn,
//   // ignore: constant_identifier_names
//   CheckOut,
// }
//
// class AttendenceScreen extends StatefulWidget {
//   const AttendenceScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AttendenceScreen> createState() => _AttendenceScreenState();
// }
//
// class _AttendenceScreenState extends State<AttendenceScreen> {
//   int? selectedRadio = 1;
//
//   TimeType timeType = TimeType.CheckIn;
//   String currentMonth = "";
//   List<String> myDate = [];
//
//   final TextEditingController _textEditingController = TextEditingController();
//   final TextEditingController selectDateController = TextEditingController();
//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController endDateController = TextEditingController();
//   final TextEditingController _firstDateController = TextEditingController();
//   final TextEditingController _secondDateController = TextEditingController();
//   String startDate = "";
//   String endDate = "";
//
//   String selectedDate = "Select";
//   DateTime currentMY = DateTime.now();
//   String formattedMY = "";
//
//   //selection of month year
//   List<int> years = [];
//   int? selectedYear; // Store the selected year
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
//   List<PdfAttendanceModel>? aList;
// //
//   @override
//   void initState() {
//     super.initState();
//     //selection of month year
//     int currentYear = DateTime.now().year;
//     int startYear = 1990;
//     for (int year = currentYear; year >= startYear; year--) {
//       years.add(year);
//     }
//     selectedYear = currentYear;
//
//     selectedMonth = DateFormat('MMMM').format(DateTime.now());
//     //
//
//     String currentMonthName = DateFormat('MMMM').format(DateTime.now());
//     _textEditingController.text = currentMonthName;
//     startDateController.text = selectedDate;
//
//     formattedMY = formatMonthAndYear(currentMY);
//     log(formattedMY, name: "formattedMY");
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final attendenceController = Get.put(AttendenceController());
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBar(
//         title: "Attendence",
//         backgroundColor: Colors.white,
//         textColor: black,
//       ),
//       body: SafeArea(
//         child: Consumer<HomeScreenProvider>(
//             builder: (context, provider, _) => Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10.0, vertical: 16),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.1),
//                               spreadRadius: 5,
//                               blurRadius: 7,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Consumer<AttendenceScreenProvider>(
//                                   builder: (context, provider, _) => Row(
//                                     children: [
//                                       Radio<int>(
//                                         value: 1,
//                                         groupValue: provider.selectedButton,
//                                         onChanged: (value) {
//                                           provider.setSelectedButton(value!);
//                                         },
//                                       ),
//                                       const Text('Monthly'),
//                                     ],
//                                   ),
//                                 ),
//                                 Consumer<AttendenceScreenProvider>(
//                                   builder: (context, provider, _) => Row(
//                                     children: [
//                                       Radio<int>(
//                                         value: 2,
//                                         groupValue: provider.selectedButton,
//                                         onChanged: (value) {
//                                           provider.setSelectedButton(value!);
//                                         },
//                                       ),
//                                       const Text('Custom'),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 20.h),
//                             Consumer<AttendenceScreenProvider>(
//                               builder: (context, provider, _) {
//                                 if (provider.selectedButton == 1) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 16.0, bottom: 8),
//                                         child: Text("Select Month"),
//                                       ),
//                                       // decoratedTextField1(context),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Container(
//                                             padding: EdgeInsets.only(
//                                                 left: 10.w, right: 6.w),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(10).r,
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.grey
//                                                       .withOpacity(0.1),
//                                                   spreadRadius: 5,
//                                                   blurRadius: 7,
//                                                   offset: const Offset(0, 3),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: DropdownButton<String>(
//                                               underline: Container(),
//
//                                               value: selectedMonth,
//                                               // Set the selected month as the value
//                                               onChanged: (String? month) {
//                                                 setState(() {
//                                                   selectedMonth =
//                                                       month; // Update the selected month
//                                                 });
//                                               },
//                                               items: [
//                                                 const DropdownMenuItem<String>(
//                                                   value: null,
//                                                   // Set the initial value to null
//                                                   child: Text('Select Month'),
//                                                 ),
//                                                 ...months.map((String month) {
//                                                   return DropdownMenuItem<
//                                                       String>(
//                                                     value: month,
//                                                     child: Text(month),
//                                                   );
//                                                 }).toList(),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.only(
//                                                 left: 10.w, right: 6.w),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(10).r,
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.grey
//                                                       .withOpacity(0.1),
//                                                   spreadRadius: 5,
//                                                   blurRadius: 7,
//                                                   offset: const Offset(0, 3),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: DropdownButton<int>(
//                                               underline: Container(),
//                                               value: selectedYear,
//                                               // Set the selected year as the value
//                                               onChanged: (int? year) {
//                                                 setState(() {
//                                                   selectedYear =
//                                                       year; // Update the selected year
//                                                 });
//                                               },
//                                               items: [
//                                                 const DropdownMenuItem<int>(
//                                                   value: null,
//                                                   // Set the initial value to null
//                                                   child: Text('Select Year'),
//                                                 ),
//                                                 ...years.map((int year) {
//                                                   return DropdownMenuItem<int>(
//                                                     value: year,
//                                                     child:
//                                                         Text(year.toString()),
//                                                   );
//                                                 }).toList(),
//                                               ],
//                                             ),
//                                           ),
//
//                                           MaterialButton(
//                                             minWidth: 50,
//                                             height: 40,
//                                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                                             color:primaryColor,
//                                 onPressed: () {
//                                 var value = 3;
//                                 provider.setSelectedButton(value);
//                                 var myYear = selectedYear;
//                                 var myMonth = selectedMonth;
//                                 log("hello $myMonth $myYear");
//                                 String yearMon = myMonth! +
//                                 " " +
//                                 myYear.toString();
//                                 log(" $yearMon", name: "yearMon");
//
//                                 Widget newWidget;
//
//                                 if (yearMon == "") {
//                                 Fluttertoast.showToast(
//                                 msg:
//                                 'Please Provide Month or Year',
//                                 );
//                                 return; // Skip creating the new widget due to invalid date range
//                                 } else {
//                                 newWidget =
//                                 attendenceHistory3(yearMon);
//                                 }
//                                 if (previousWidget != null) {
//                                 columnChildren2.remove(
//                                 previousWidget); // Remove the previous widget
//                                 }
//
//                                 previousWidget =
//                                 newWidget; // Set the new widget as the previous one
//
//                                 columnChildren2.add(
//                                 newWidget); // Add the new widget to the list
//                                 setState(() {});
//                                 }, child: Icon(Icons.search,color: white,)),
//
//
//                                         ],
//                                       ),
//
//                                       SizedBox(
//                                         height: 20.h,
//                                       ),
//                                       // Align(
//                                       //   alignment: Alignment.center,
//                                       //   child: CustomButton(
//                                       //     width: 150.w,
//                                       //     textColor: const Color.fromRGBO(
//                                       //         255, 255, 255, 1),
//                                       //     height: 50.h,
//                                       //     text: "Find Record",
//                                       //     color: primaryColor,
//                                       //     onPressed: () {
//                                       //       var value = 3;
//                                       //       provider.setSelectedButton(value);
//                                       //       var myYear = selectedYear;
//                                       //       var myMonth = selectedMonth;
//                                       //       log("hello $myMonth $myYear");
//                                       //       String yearMon = myMonth! +
//                                       //           " " +
//                                       //           myYear.toString();
//                                       //       log(" $yearMon", name: "yearMon");
//                                       //
//                                       //       Widget newWidget;
//                                       //
//                                       //       if (yearMon == "") {
//                                       //         Fluttertoast.showToast(
//                                       //           msg:
//                                       //               'Please Provide Month or Year',
//                                       //         );
//                                       //         return; // Skip creating the new widget due to invalid date range
//                                       //       } else {
//                                       //         newWidget =
//                                       //             attendenceHistory3(yearMon);
//                                       //       }
//                                       //       if (previousWidget != null) {
//                                       //         columnChildren2.remove(
//                                       //             previousWidget); // Remove the previous widget
//                                       //       }
//                                       //
//                                       //       previousWidget =
//                                       //           newWidget; // Set the new widget as the previous one
//                                       //
//                                       //       columnChildren2.add(
//                                       //           newWidget); // Add the new widget to the list
//                                       //       setState(() {});
//                                       //     },
//                                       //   ),
//                                       // ),
//
//                                     ],
//                                   );
//                                 }
//                                 if (provider.selectedButton == 3) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 16.0, bottom: 8),
//                                         child: Text("Select Month"),
//                                       ),
//                                       // decoratedTextField1(context),
//                                       Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Container(
//                                               padding: EdgeInsets.only(
//                                                   left: 10.w, right: 6.w),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.1),
//                                                     spreadRadius: 5,
//                                                     blurRadius: 7,
//                                                     offset: const Offset(0, 3),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: DropdownButton<String>(
//                                                 underline: Container(),
//
//                                                 value: selectedMonth,
//                                                 // Set the selected month as the value
//                                                 onChanged: (String? month) {
//                                                   setState(() {
//                                                     selectedMonth =
//                                                         month; // Update the selected month
//                                                   });
//                                                 },
//                                                 items: [
//                                                   const DropdownMenuItem<
//                                                       String>(
//                                                     value: null,
//                                                     // Set the initial value to null
//                                                     child: Text('Select Month'),
//                                                   ),
//                                                   ...months.map((String month) {
//                                                     return DropdownMenuItem<
//                                                         String>(
//                                                       value: month,
//                                                       child: Text(month),
//                                                     );
//                                                   }).toList(),
//                                                 ],
//                                               ),
//                                             ),
//                                             Container(
//                                               padding: EdgeInsets.only(
//                                                   left: 10.w, right: 6.w),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.1),
//                                                     spreadRadius: 5,
//                                                     blurRadius: 7,
//                                                     offset: const Offset(0, 3),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: DropdownButton<int>(
//                                                 underline: Container(),
//                                                 value: selectedYear,
//                                                 // Set the selected year as the value
//                                                 onChanged: (int? year) {
//                                                   setState(() {
//                                                     selectedYear =
//                                                         year; // Update the selected year
//                                                   });
//                                                 },
//                                                 items: [
//                                                   const DropdownMenuItem<int>(
//                                                     value: null,
//                                                     // Set the initial value to null
//                                                     child: Text('Select Year'),
//                                                   ),
//                                                   ...years.map((int year) {
//                                                     return DropdownMenuItem<
//                                                         int>(
//                                                       value: year,
//                                                       child:
//                                                           Text(year.toString()),
//                                                     );
//                                                   }).toList(),
//                                                 ],
//                                               ),
//                                             ),
//                                           ]),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           CustomButton(
//                                             width: 150.w,
//                                             textColor: Colors.white,
//                                             height: 50.h,
//                                             text: "Find Record",
//                                             color: primaryColor,
//                                             onPressed: () {
//                                               var value = 3;
//                                               provider.setSelectedButton(value);
//                                               var myYear = selectedYear;
//                                               var myMonth = selectedMonth;
//
//                                               log("hello $myMonth $myYear");
//                                               String yearMon = myMonth! +
//                                                   " " +
//                                                   myYear.toString();
//                                               log(" $yearMon", name: "yearMon");
//
//                                               Widget newWidget;
//
//                                               if (yearMon == "") {
//                                                 Fluttertoast.showToast(
//                                                   msg:
//                                                       'Please Provide Month or Year',
//                                                 );
//                                                 return; // Skip creating the new widget due to invalid date range
//                                               } else {
//                                                 newWidget =
//                                                     attendenceHistory3(yearMon);
//                                               }
//                                               if (previousWidget != null) {
//                                                 columnChildren2.remove(
//                                                     previousWidget); // Remove the previous widget
//                                               }
//
//                                               previousWidget =
//                                                   newWidget; // Set the new widget as the previous one
//
//                                               columnChildren2.add(
//                                                   newWidget); // Add the new widget to the list
//                                               setState(() {});
//                                             },
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   );
//                                 } else if (provider.selectedButton == 2) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 16.0, bottom: 8),
//                                         child: Text("Select Date"),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                               child:
//                                                   decoratedTextField2(context)),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                           Expanded(
//                                               child:
//                                                   decoratedTextField3(context)),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           CustomButton(
//                                             width: 150.w,
//                                             textColor: Colors.white,
//                                             height: 50.h,
//                                             text: "Find Record",
//                                             color: primaryColor,
//                                             onPressed: () {
//                                               if (startDate.isEmpty ||
//                                                   endDate.isEmpty) {
//                                                 Fluttertoast.showToast(
//                                                     msg:
//                                                         "Please Fill Both Date");
//                                               } else {
//                                                 DateTime startDateTime =
//                                                     DateTime.parse(startDate);
//                                                 DateTime endDateTime =
//                                                     DateTime.parse(endDate);
//                                                 Widget newWidget1;
//                                                 if (endDateTime
//                                                     .isBefore(startDateTime)) {
//                                                   Fluttertoast.showToast(
//                                                     msg:
//                                                         'End date must be greater than start date',
//                                                   );
//                                                   return; // Skip creating the new widget due to invalid date range
//                                                 } else {
//                                                   newWidget1 =
//                                                       attendenceHistory2(
//                                                           startDate, endDate);
//                                                 }
//
//                                                 if (previousWidget != null) {
//                                                   columnChildren.remove(
//                                                       previousWidget); // Remove the previous widget
//                                                 }
//
//                                                 previousWidget =
//                                                     newWidget1; // Set the new widget as the previous one
//
//                                                 columnChildren.add(
//                                                     newWidget1); // Add the new widget to the list
//                                                 setState(() {});
//                                               }
//                                             },
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   );
//                                 } else {
//                                   return Container(); // Default case
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Expanded(
//                         child: Consumer<AttendenceScreenProvider>(
//                             builder: (context, provider, _) {
//                           if (provider.selectedButton == 1) {
//                             return attendenceHistory1();
//                           } else if (provider.selectedButton == 2) {
//                             return Column(children: columnChildren);
//                           } else if (provider.selectedButton == 3) {
//                             provider.selectedButton == 2;
//                             return Column(children: columnChildren2);
//                           } else {
//                             return Container();
//                           }
//                         }),
//                       ),
//                     ],
//                   ),
//                 )),
//       ),
//     );
//   }
//
//   Widget attendenceHistory1() {
//     return Container(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
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
//       child: Column(children: [
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             CustomText(
//               text: "Attendance History",
//               color: black,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600,
//             ),
//             const Spacer(),
//             GestureDetector(
//                 onTap: () {
//                   if (aList == null) {
//                     Fluttertoast.showToast(msg: "List is empty");
//                     return;
//                   }
//                   PdfHanlder.makeAttendanceHistoryReport(aList!);
//                 },
//                 child: Icon(
//                   Icons.print,
//                   color: primaryColor,
//                   size: 24.sp,
//                 )),
//             const SizedBox(width: 20),
//             GestureDetector(
//                 onTap: () {
//                   // Handle download action
//                 },
//                 child: Icon(
//                   Icons.cloud_download_outlined,
//                   color: primaryColor,
//                   size: 24.sp,
//                 )),
//           ],
//         ),
//         const SizedBox(
//           height: 18,
//         ),
//         Expanded(
//           child: Consumer<HomeScreenProvider>(
//             builder: (context, provider, _) {
//               return StreamBuilder<List<Map<String, dynamic>>>(
//                 stream: provider.fetchCheckInTimes(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     final checkInRecords = snapshot.data!;
//                     String currentUserUid =
//                         FirebaseAuth.instance.currentUser!.uid;
//                     DateTime currentMY = DateTime.now();
//                     final DateFormat formatter = DateFormat.yMMMM();
//                     String currentMYresult = formatter.format(currentMY);
//
//                     String currentDate = provider.getCurrentDate();
//                     String formattedDateddd = provider.formatDate(currentDate);
//                     // Filter the check-in records for the current user
//                     final filteredRecords = checkInRecords
//                         .where((record) =>
//                             record['currentUserId'] == currentUserUid &&
//                             record['currentMY'] == currentMYresult)
//                         .toList();
//
//                     if (filteredRecords.isEmpty) {
//                       return const Text(
//                           'No data available for the current user');
//                     }
//                     aList = filteredRecords
//                         .map((e) => PdfAttendanceModel(
//                             type: e['checkOutTime'] == ''
//                                 ? "Check In"
//                                 : "Check Out",
//                             date: e['date'],
//                             time: e['checkInTime'],
//                             description:
//                                 calculateLateTime('09:00', e['checkInTime'])))
//                         .toList();
//                     return ListView.builder(
//                       itemCount: filteredRecords.length,
//                       itemBuilder: (context, index) {
//                         final record = filteredRecords[index];
//                         final checkInTime = record['checkInTime'];
//                         final checkOutTime = record['checkOutTime'];
//
//                         final date = record['date'];
//
//                         var actualTime = checkInTime;
//                         String arrivalTime = '09:00';
//                         String departureTime = '17:00';
//                         String cal = calculateLateTime(arrivalTime, actualTime);
//                         String workTime = calculateWorkTime(checkInTime,
//                             (checkOutTime! == null) ? 0 : checkOutTime);
//
//                         String dt = date;
//                         myDate.add(dt);
//                         int khan = myDate.length;
//                         myDate.where((dt) {
//                           DateTime date = DateTime.parse(dt);
//                           return DateFormat.yMMMM().format(date) == formattedMY;
//                         }).toList();
//
//                         if (formattedMY == null) {
//                           return const Text("No CheckedIn CheckedOut Record");
//                         }
//                         return Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 35,
//                                   height: 35,
//                                   decoration: BoxDecoration(
//                                     color: halfGreenColorText,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: Image(
//                                       color: primaryColor,
//                                       image: const AssetImage(
//                                           "assets/images/checkIn.png"),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const CustomText(
//                                       text: "Check In",
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: black,
//                                     ),
//                                     CustomText(
//                                       text: date,
//                                       fontSize: 8,
//                                       color: halfSilverColorText,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ],
//                                 ),
//                                 const Spacer(),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     CustomText(
//                                       text: checkInTime,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: black,
//                                     ),
//                                     CustomText(
//                                       text: cal,
//                                       fontSize: 8,
//                                       color: halfSilverColorText,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                                 height: 12), // Add spacing between the rows
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 35,
//                                   height: 35,
//                                   decoration: BoxDecoration(
//                                     color: fullhalfRedColor,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: Image(
//                                       color: primaryColor,
//                                       image: const AssetImage(
//                                           "assets/images/checkIn.png"),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const CustomText(
//                                       text: "Check Out",
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: black,
//                                     ),
//                                     CustomText(
//                                       text: date,
//                                       fontSize: 8,
//                                       color: halfSilverColorText,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ],
//                                 ),
//                                 const Spacer(),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     CustomText(
//                                       text: checkOutTime,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: black,
//                                     ),
//                                     CustomText(
//                                       text: workTime == null
//                                           ? ("You Have Not Selected CheckOut Yet")
//                                           : workTime,
//                                       fontSize: 8,
//                                       color: halfSilverColorText,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                           ],
//                         );
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return const Text('Failed to retrieve check-in times');
//                   } else {
//                     return const CircularProgressIndicator();
//                   }
//                 },
//               );
//             },
//           ),
//         )
//       ]),
//     );
//   }
//
//   Widget attendenceHistory3(String yearMonth) {
//     log("attendenceHistory3 $yearMonth");
//
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 const CustomText(
//                   text: "Attendance History",
//                   color: black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 const Spacer(),
//                 GestureDetector(
//                     onTap: () {
//                       // Handle print action
//                     },
//                     child: Icon(
//                       Icons.print,
//                       color: primaryColor,
//                       size: 24.sp,
//                     )),
//                 const SizedBox(width: 20),
//                 GestureDetector(
//                     onTap: () {
//                       // Handle download action
//                     },
//                     child: Icon(
//                       Icons.cloud_download_outlined,
//                       color: primaryColor,
//                       size: 24.sp,
//                     )),
//               ],
//             ),
//             const SizedBox(
//               height: 18,
//             ),
//             Expanded(
//               child: Consumer<HomeScreenProvider>(
//                 builder: (context, provider, _) {
//                   return StreamBuilder<List<Map<String, dynamic>>>(
//                     stream: provider.fetchCheckInTimes(),
//                     builder: (context, snapshot) {
//                       log("snapshot hasData call");
//                       if (snapshot.hasData) {
//                         log("snapshot hasData call");
//                         final checkInRecords = snapshot.data!;
//                         final currentUserUid =
//                             FirebaseAuth.instance.currentUser!.uid;
//
//                         final filteredRecords = checkInRecords.where((record) {
//                           try {
//                             return record['currentUserId'] == currentUserUid &&
//                                 record['currentMY'] == yearMonth;
//                           } catch (e) {
//                             Fluttertoast.showToast(msg: e.toString());
//                             return false;
//                           }
//                         }).toList();
//
//                         log("filteredRecords: $filteredRecords");
//
//                         if (filteredRecords.isEmpty) {
//                           log("filteredRecords is empty");
//                           return const Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Center(child: Text('No data')),
//                             ],
//                           );
//                         }
//                         aList = filteredRecords
//                             .map((e) => PdfAttendanceModel(
//                                 type: e['checkOutTime'] == ''
//                                     ? "Check In"
//                                     : "Check Out",
//                                 date: e['date'],
//                                 time: e['checkInTime'],
//                                 description: calculateLateTime(
//                                     '09:00', e['checkInTime'])))
//                             .toList();
//                         return ListView.builder(
//                           itemCount: filteredRecords.length,
//                           itemBuilder: (context, index) {
//                             final record = filteredRecords[index];
//                             final checkInTime = record['checkInTime'];
//                             final checkOutTime = record['checkOutTime'];
//
//                             final date = record['date'];
//
//                             var actualTime = checkInTime;
//                             String arrivalTime = '09:00';
//                             String departureTime = '17:00';
//                             String cal =
//                                 calculateLateTime(arrivalTime, actualTime);
//                             String workTime = calculateWorkTime(checkInTime,
//                                 (checkOutTime! == null) ? 0 : checkOutTime);
//
//                             String dt = date;
//                             myDate.add(dt);
//                             myDate.where((dt) {
//                               DateTime date = DateTime.parse(dt);
//                               return DateFormat.yMMMM().format(date) ==
//                                   formattedMY;
//                             }).toList();
//                             if (formattedMY == null) {
//                               return const Text(
//                                   "No CheckedIn CheckedOut Record");
//                             }
//                             return Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Container(
//                                       width: 35,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                         color: halfGreenColorText,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: SizedBox(
//                                         width: 20,
//                                         height: 20,
//                                         child: Image(
//                                           color: primaryColor,
//                                           image: const AssetImage(
//                                               "assets/images/checkIn.png"),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const CustomText(
//                                           text: "Check In",
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600,
//                                           color: black,
//                                         ),
//                                         CustomText(
//                                           text: date,
//                                           fontSize: 8,
//                                           color: halfSilverColorText,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ],
//                                     ),
//                                     const Spacer(),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         CustomText(
//                                           text: checkInTime,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600,
//                                           color: black,
//                                         ),
//                                         CustomText(
//                                           text: cal,
//                                           fontSize: 8,
//                                           color: halfSilverColorText,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                                 // Add spacing between the rows
//                                 Row(
//                                   children: [
//                                     Container(
//                                       width: 35,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                         color: fullhalfRedColor,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: SizedBox(
//                                         width: 20,
//                                         height: 20,
//                                         child: Image(
//                                           color: primaryColor,
//                                           image: const AssetImage(
//                                               "assets/images/checkIn.png"),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const CustomText(
//                                           text: "Check Out",
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600,
//                                           color: black,
//                                         ),
//                                         CustomText(
//                                           text: date,
//                                           fontSize: 8,
//                                           color: halfSilverColorText,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ],
//                                     ),
//                                     const Spacer(),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         CustomText(
//                                           text: checkOutTime,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600,
//                                           color: black,
//                                         ),
//                                         CustomText(
//                                           text: workTime == null
//                                               ? ("You Have Not Selected CheckOut Yet")
//                                               : workTime,
//                                           fontSize: 8,
//                                           color: halfSilverColorText,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                               ],
//                             );
//                           },
//                         );
//                       } else if (snapshot.hasError) {
//                         return const Text('Failed to retrieve check-in times');
//                       } else {
//                         return const CircularProgressIndicator();
//                       }
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget decoratedTextField1(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
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
//       child: TextField(
//         controller: _textEditingController,
//         readOnly: true,
//         onTap: () {
//           _selectDate(context);
//         },
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           suffixIcon: Icon(Icons.calendar_today),
//           filled: true,
//           fillColor: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget decoratedTextField2(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
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
//       child: TextField(
//         controller: _firstDateController,
//         readOnly: true,
//         onTap: () {
//           _selectFirstDate(context);
//         },
//         decoration: InputDecoration(
//           border: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           suffixIcon: _firstDateController.text.isNotEmpty
//               ? null
//               : const Icon(Icons.calendar_today),
//           filled: true,
//           fillColor: Colors.white,
//           hintText: "Start Date",
//         ),
//       ),
//     );
//   }
//
//   Widget decoratedTextField3(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
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
//       child: TextField(
//         controller: _secondDateController,
//         readOnly: true,
//         onTap: () {
//           _selectSecondDate(context);
//         },
//         decoration: InputDecoration(
//           border: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           suffixIcon: _secondDateController.text.isNotEmpty
//               ? null
//               : const Icon(Icons.calendar_today),
//           filled: true,
//           fillColor: Colors.white,
//           hintText: "End Date",
//         ),
//       ),
//     );
//   }
//
//   String calculateLateTime(String arrivalTime, String actualArrivalTime) {
//     // Convert arrival time to minutes
//     List<String> arrivalParts = arrivalTime.split(":");
//     int arrivalMinutes =
//         int.parse(arrivalParts[0]) * 60 + int.parse(arrivalParts[1]);
//
//     // Convert actual arrival time to minutes
//     List<String> actualArrivalParts = actualArrivalTime.split(":");
//     int actualArrivalMinutes = int.parse(actualArrivalParts[0]) * 60 +
//         int.parse(actualArrivalParts[1]);
//
//     // Calculate late time
//     int lateTimeMinutes = actualArrivalMinutes - arrivalMinutes;
//
//     // Convert late time to hours and minutes
//     int hours = lateTimeMinutes ~/ 60;
//     int minutes = lateTimeMinutes % 60;
//
//     return "You arrived $hours Hr $minutes Min Late";
//   }
//
//   String calculateWorkTime(String checkInTime, String? checkOutTime) {
//     try {
//       // Convert check-in time to minutes
//       List<String> checkInParts = checkInTime.split(":");
//       int checkInMinutes =
//           int.parse(checkInParts[0]) * 60 + int.parse(checkInParts[1]);
//
//       // Calculate work time
//       int workTimeMinutes;
//
//       if (checkOutTime != null) {
//         // Convert check-out time to minutes
//         List<String> checkOutParts = checkOutTime.split(":");
//         int checkOutMinutes =
//             int.parse(checkOutParts[0]) * 60 + int.parse(checkOutParts[1]);
//
//         workTimeMinutes = checkOutMinutes - checkInMinutes;
//       } else {
//         // Set work time as 0 if check-out time is null
//         workTimeMinutes = 0;
//       }
//
//       // Convert work time to hours and minutes
//       int hours = workTimeMinutes ~/ 60;
//       int minutes = workTimeMinutes % 60;
//
//       return "You have worked: $hours Hr $minutes Min";
//     } catch (FormatException) {
//       return "You have not CheckOut Yet.";
//     }
//   }
//
//   Future<void> _selectFirstDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) picked.toString();
//     DateTime dateTime = DateTime.parse(picked.toString());
//
//     // Format the date
//     DateFormat formatter = DateFormat('yyyy-MM-dd');
//     String formattedDate = formatter.format(dateTime);
//     startDate = formattedDate;
//     _firstDateController.text = startDate;
//     log(startDate, name: "StartDate");
//
//     setState(() {});
//   }
//
//   Future<void> _selectSecondDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.parse(startDate),
//       lastDate: DateTime(2100),
//     );
//
//     if (picked != null) picked.toString();
//     DateTime dateTime = DateTime.parse(picked.toString());
//
//     // Format the date
//     DateFormat formatter = DateFormat('yyyy-MM-dd');
//     String formattedDate = formatter.format(dateTime);
//     endDate = formattedDate;
//     _secondDateController.text = endDate;
//     log(endDate, name: "endDate");
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//
//     if (selectedDate != null) {
//       String monthName = DateFormat('MMMM').format(selectedDate);
//
//       _textEditingController.text = monthName;
//       currentMonth = _textEditingController.text;
//       log(currentMonth, name: "currentMonth");
//     } else {
//       // If no date is selected, set the current month as the default value
//       String currentMonthName = DateFormat('MMMM').format(DateTime.now());
//       _textEditingController.text = currentMonthName;
//
//       log("$_textEditingController", name: "currentMonthName");
//     }
//   }
//
//   String formatMonthAndYear(DateTime date) {
//     final DateFormat formatter = DateFormat.yMMMM();
//     return formatter.format(date);
//   }
//
//   List<Widget> columnChildren = [];
//   List<Widget> columnChildren2 = [];
//   Widget? previousWidget;
//
//   Widget attendenceHistory2(String startDate, String endDate) {
//     log("attendenceHistory3 call");
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(children: [
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               const CustomText(
//                 text: "Attendance History",
//                 color: black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//               const Spacer(),
//               GestureDetector(
//                   onTap: () {
//                     // Handle print action
//                   },
//                   child: Icon(
//                     Icons.print,
//                     color: primaryColor,
//                     size: 24.sp,
//                   )),
//               const SizedBox(width: 20),
//               GestureDetector(
//                   onTap: () {
//                     // Handle download action
//                   },
//                   child: Icon(
//                     Icons.cloud_download_outlined,
//                     color: primaryColor,
//                     size: 24.sp,
//                   )),
//             ],
//           ),
//           const SizedBox(
//             height: 18,
//           ),
//           Expanded(
//             child: Consumer<HomeScreenProvider>(
//               builder: (context, provider, _) {
//                 return StreamBuilder<List<Map<String, dynamic>>>(
//                   stream: provider.fetchCheckInTimes(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       final checkInRecords = snapshot.data!;
//                       final currentUserUid =
//                           FirebaseAuth.instance.currentUser!.uid;
//                       DateTime currentMY = DateTime.now();
//                       final DateFormat formatter = DateFormat.yMMMM();
//                       var waqas = formatter.format(currentMY);
//                       log(waqas, name: "waqas");
//
//                       final filteredRecords = checkInRecords.where((record) {
//                         try {
//                           // Parse start and end dates
//                           DateTime startDateTime = DateTime.parse(startDate);
//                           DateTime endDateTime = DateTime.parse(endDate);
//                           // Check if end date is smaller than start date
//                           if (endDateTime.isBefore(startDateTime)) {
//                             Fluttertoast.showToast(
//                                 msg:
//                                     'End date must be greater than start date');
//                             return false; // Skip this record due to invalid date range
//                           }
//                           // Filter condition: currentUserId matches and date is within the range
//                           DateTime recordDate = DateTime.parse(record['date']);
//
//                           return record['currentUserId'] == currentUserUid &&
//                                   recordDate.isAfter(startDateTime) &&
//                                   recordDate.isBefore(endDateTime) ||
//                               recordDate.isAtSameMomentAs(startDateTime) &&
//                                   recordDate.isAtSameMomentAs(endDateTime);
//                         } catch (e) {
//                           Fluttertoast.showToast(
//                               msg: 'Please provide valid date format');
//                           return false; // Skip this record due to invalid date format
//                         }
//                       }).toList();
//
//                       log("$filteredRecords", name: "filteredRecords");
//
//                       if (filteredRecords.isEmpty) {
//                         return const Text('No data');
//                       }
//                       aList = [];
//                       for (var e in filteredRecords) {
//                         aList!.add(PdfAttendanceModel(
//                             type: "Check In",
//                             date: e['date'],
//                             time: e['checkInTime'],
//                             description:
//                                 calculateLateTime('09:00', e['checkInTime'])));
//                         aList!.add(PdfAttendanceModel(
//                             type: "Check Out",
//                             date: e['date'],
//                             time: e['checkOutTime'],
//                             description:
//                                 calculateLateTime('09:00', e['checkInTime'])));
//                       }
//                       return ListView.builder(
//                         itemCount: filteredRecords.length,
//                         itemBuilder: (context, index) {
//                           final record = filteredRecords[index];
//                           final checkInTime = record['checkInTime'];
//                           final checkOutTime = record['checkOutTime'];
//
//                           final date = record['date'];
//
//                           var actualTime = checkInTime;
//                           String arrivalTime = '09:00';
//                           String departureTime = '17:00';
//                           String cal =
//                               calculateLateTime(arrivalTime, actualTime);
//                           String workTime = calculateWorkTime(checkInTime,
//                               (checkOutTime! == null) ? 0 : checkOutTime);
//
//                           String dt = date;
//                           myDate.add(dt);
//                           int khan = myDate.length;
//                           log("$khan", name: "khan");
//                           myDate.where((dt) {
//                             DateTime date = DateTime.parse(dt);
//                             return DateFormat.yMMMM().format(date) ==
//                                 formattedMY;
//                           }).toList();
//                           // bool waqas = (dt ==);
//
//                           log("$dt", name: "dt");
//                           // ignore: unnecessary_null_comparison
//                           if (formattedMY == null) {
//                             return const Text("No CheckedIn CheckedOut Record");
//                           }
//                           // else if(formattedMY)
//                           return Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 35,
//                                     height: 35,
//                                     decoration: BoxDecoration(
//                                       color: halfGreenColorText,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: Image(
//                                         color: primaryColor,
//                                         image: const AssetImage(
//                                             "assets/images/checkIn.png"),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const CustomText(
//                                         text: "Check In",
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                         color: black,
//                                       ),
//                                       CustomText(
//                                         text: date,
//                                         fontSize: 8,
//                                         color: halfSilverColorText,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ],
//                                   ),
//                                   const Spacer(),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       CustomText(
//                                         text: checkInTime,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                         color: black,
//                                       ),
//                                       CustomText(
//                                         text: cal,
//                                         fontSize: 8,
//                                         color: halfSilverColorText,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                   height: 12), // Add spacing between the rows
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 35,
//                                     height: 35,
//                                     decoration: BoxDecoration(
//                                       color: fullhalfRedColor,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: Image(
//                                         color: primaryColor,
//                                         image: const AssetImage(
//                                             "assets/images/checkIn.png"),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const CustomText(
//                                         text: "Check Out",
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                         color: black,
//                                       ),
//                                       CustomText(
//                                         text: date,
//                                         fontSize: 8,
//                                         color: halfSilverColorText,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ],
//                                   ),
//                                   const Spacer(),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       CustomText(
//                                         text: checkOutTime,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                         color: black,
//                                       ),
//                                       CustomText(
//                                         text: workTime == null
//                                             ? ("You Have Not Selected CheckOut Yet")
//                                             : workTime,
//                                         fontSize: 8,
//                                         color: halfSilverColorText,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                             ],
//                           );
//                         },
//                       );
//                     } else if (snapshot.hasError) {
//                       return const Text('Failed to retrieve check-in times');
//                     } else {
//                       return const CircularProgressIndicator();
//                     }
//                   },
//                 );
//               },
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/custom_text.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../components/button_comp.dart';

class AttendenceScreen extends StatefulWidget {
  final Map<String, dynamic>? employeeData;

  const AttendenceScreen({super.key, this.employeeData});

  @override
  State<AttendenceScreen> createState() => _EmployeAttendanceState();
}

class _EmployeAttendanceState extends State<AttendenceScreen> {
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
    int startYear = 2020;
    for (int year = currentYear; year >= startYear; year--) {
      years.add(year);
    }
    selectedYear = currentYear;
    selectedMonth = DateFormat('MMMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.employeeData!['name']);
    debugPrint(widget.employeeData!['id']);
    debugPrint('this is current user id');

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const CustomText(
            text: 'Attendance',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
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
                          padding: const EdgeInsets.only(left: 10, right: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
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

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/print1.png',
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            attendenceReportDiaog(context);
                          },
                          child: Image.asset(
                            'assets/images/download.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),

                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('checkInOut')
                          .where('currentUserId',
                              isEqualTo: widget.employeeData!['id'])
                          .where('unixTimestamp',
                              isGreaterThanOrEqualTo: startOfMonth)
                          .where('unixTimestamp', isLessThan: endOfMonth)
                          .orderBy("unixTimestamp")
                          .snapshots(),
                      // this is simple query
                      // FirebaseFirestore.instance
                      //     .collection('checkInOut')
                      //     .where('currentUserId', isEqualTo: widget.currentUserId)
                      //     .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (!snapshot.hasData) {
                          return const Text('No data found ');
                        } else if (snapshot.data.docs.isEmpty) {
                          return const Text(
                              'No data found of the current user');
                        } else if (snapshot.hasError) {
                          return Text('Error ${snapshot.hasError}');
                        } else {
                          documentList = snapshot
                              .data.docs; // List of QueryDocumentSnapshot
                          return Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 15,
                                ),
                                itemBuilder: (context, index) {
                                  dutyDuration = documentList[index]
                                              ['checkOutTime'] ==
                                          ''
                                      ? '0 hours 0 minuts'
                                      : calculateDutyDuration(
                                          documentList[index]['checkInTime'],
                                          documentList[index]['checkOutTime']);
                                  bool absent = documentList[index]['isAbsent'];
                                  bool leave = documentList[index]['isLeave'];
                                  return absent
                                      ? GestureDetector(
                                          onTap: () {},
                                          child: leaveAbsentWidget(
                                              title: 'Absent',
                                              color: Colors.red,
                                              index: index,
                                              documentList: documentList),
                                        )
                                      : leave
                                          ? GestureDetector(
                                              onTap: () {},
                                              child: leaveAbsentWidget(
                                                  title: 'Leave',
                                                  color: primaryColor,
                                                  index: index,
                                                  documentList: documentList),
                                            )
                                          : presentWidget(
                                              context, index, documentList);
                                },
                                itemCount: documentList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
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
            ),
          ),
        ));
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
                0: const pw.IntrinsicColumnWidth(),
                1: const pw.IntrinsicColumnWidth(),
                2: const pw.IntrinsicColumnWidth(),
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
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                    const Text(
                      'Download Now',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Attendence Report is being downloading...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: black,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
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
          color: white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(2, 2),
              color: black.withOpacity(0.10),
            )
          ]),
      child: ExpansionTileCard(
        contentPadding: const EdgeInsets.all(0),
        baseColor: white,
        trailing: const SizedBox(
          height: 0,
          width: 0,
        ),
        title: const Text(''),
        subtitle: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                // flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(1, 1),
                              color: black.withOpacity(0.20))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: formattedDate,
                              // 'Wed',

                              color: primaryColor, fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: formateDay,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            )
                          ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const CustomText(
                  text: 'Check in',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: documentList[index]['checkInTime'],
                  fontSize: 16,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/location2.png',
                      height: 10,
                      width: 10,
                    ),
                    const CustomText(
                      text: 'Islamabad i-10',
                      fontSize: 8,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                )
              ]),
              const VerticalDivider(
                thickness: 1,
                indent: 16,
                endIndent: 34,
                color: Color(0xffE9E9E9),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const CustomText(
                  text: 'Check Out',
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
                CustomText(
                  text: documentList[index]['checkOutTime'] == ""
                      ? 'No checkout'
                      : documentList[index]['checkOutTime'],
                  fontSize: documentList[index]['checkOutTime'] == "" ? 12 : 16,
                  color: documentList[index]['checkOutTime'] == ""
                      ? redColor
                      : null,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/location2.png',
                      height: 10,
                      width: 10,
                    ),
                    const CustomText(
                      text: 'Islamabad i-10',
                      fontSize: 8,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
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
      height: 78,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(2, 2),
              color: black.withOpacity(0.10),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(2, 2),
                  color: black.withOpacity(0.10),
                )
              ], color: white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: formateDay,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: formattedDate,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Center(child: CustomText(text: title, color: color)))
        ]),
      ),
    );
  }
}
