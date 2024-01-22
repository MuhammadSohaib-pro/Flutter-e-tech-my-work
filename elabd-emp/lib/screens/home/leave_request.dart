import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elabd_tms_app/models/leave_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../components/button_comp.dart';
import '../../components/custom_text.dart';
import '../../components/multi_line_textfield_widget.dart';
import '../../components/text_field_widget.dart';
import '../../constants/colors.dart';
import 'package:http/http.dart' as http;
import '../../services/notification_services.dart';

class LeaveRequests extends StatefulWidget {
  const LeaveRequests({super.key});

  @override
  State<LeaveRequests> createState() => _LeaveRequestsState();
}

class _LeaveRequestsState extends State<LeaveRequests> {
  final List<String> leaveList = [
    'Sick Leave',
    'Annual Leave',
    'Parental Leave',
    'Upaid Leave',
    'Leave',
    'Public Holiday',
  ];
  String? leaveSelectedValue;

  final fromController = TextEditingController();
  final toController = TextEditingController();
  final reasonController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? myformattedMY;
  NotificationServices notificationServices = NotificationServices();
  Future startDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null) {
      if (selectedEndDate != null && picked.isAfter(selectedEndDate!)) {
        // Invalid start date, show error message
        Fluttertoast.showToast(msg: 'Start date cannot be after end date.');
      } else {
        setState(() {
          selectedStartDate = picked;
          String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
          fromController.text = formattedDate;
        });
      }
    }
  }

  Future endDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null) {
      if (selectedStartDate != null && picked.isBefore(selectedStartDate!)) {
        Fluttertoast.showToast(msg: 'End date cannot be before start date.');
      } else {
        setState(() {
          selectedEndDate = picked;
          String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
          toController.text = formattedDate;
        });
      }
    }
  }

  List<String> deviceTokens = []; 
  Future<void> sendNotification(String message) async {
    final deviceTokenSnapshot = await FirebaseFirestore.instance
        .collection('employees')
        .where('role', isEqualTo: 'Admin')
        .get();

    if (deviceTokenSnapshot != null) {
      for (var document in deviceTokenSnapshot.docs) {
        // Access the 'deviceToken' field and add it to the list
        String deviceToken = document['fcmToken'];
        deviceTokens.add(deviceToken);
      }

      // String? myToken = await notificationServices.getDeviceToken();

      // // Fetch the employee's name associated with the device token
      // DocumentSnapshot employeeDoc = await FirebaseFirestore.instance
      //     .collection('employees')
      //     .where('fcmToken', isEqualTo: myToken)
      //     .limit(1)
      //     .get()
      //     .then((querySnapshot) => querySnapshot.docs.first);
      //     String employeeName = employeeDoc['name'];
      final data = {
        'registration_ids': deviceTokens,
        'priority': 'high',
        'notification': {'title': 'New Message', 'body': message}
      };
      print(deviceTokens);

      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAl8yn4mw:APA91bEZK68EvntCRTTTS7DT7YNb8KiKnVoDjPqRQ_2arUus-MY00PdSDkppe9iakGui2NJiPIW74N8EqN16kjiR9bxJmKTP4zWovCdkt7UJ2dAj8z2qFuuN_anYhHECVh4kVhspBXj9'
        },
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Error sending notification: ${response.body}');
      }
    } else {
      print('Recipient device token not found');
    }
  }

  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print('Device Token is');
      print(value);
    });
    super.initState();
  }

  String formatMonthAndYear(DateTime date) {
    final DateFormat formatter = DateFormat.yMMMM();
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Requests'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    addLeaveRequest();
                  },
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Request',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: white),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('leaveRequests')
                      .where('userId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data.docs.isEmpty) {
                      return const Text('No data found of the current user');
                    } else if (!snapshot.hasData) {
                      return const Text('There is no data found');
                    } else {
                      final querySnapshot = snapshot.data!;
                      // Iterate through documents and process data
                      List<QueryDocumentSnapshot> documents =
                          querySnapshot.docs;
                      return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 14,
                              ),
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data =
                                documents[index].data() as Map<String, dynamic>;
                            // Access data properties and build UI here
                            return Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: const Offset(2, 2),
                                          color: black.withOpacity(0.10))
                                    ]),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    child: Column(children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              data['image'],
                                            ),
                                            radius: 25,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  data['name'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  data['team'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: primaryColor,
                                                      fontSize: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF6F6F6),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [],
                                              ),
                                              Text(
                                                data['desc'],
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // data['notes'] == ''
                                      //     ? const SizedBox(
                                      //         height: 0,
                                      //         width: 0,
                                      //       )
                                      //     : const Align(
                                      //         alignment: Alignment.centerLeft,
                                      //         child: Text(
                                      //           'Admin Action',
                                      //           style: TextStyle(
                                      //               fontSize: 12,
                                      //               fontWeight: FontWeight.w500,
                                      //               color: primaryColor),
                                      //         )),
                                      // data['notes'] == ''
                                      //     ? const SizedBox(
                                      //         height: 0,
                                      //         width: 0,
                                      //       )
                                      //     : Container(
                                      //         margin:
                                      //             const EdgeInsets.symmetric(
                                      //                 horizontal: 8),
                                      //         decoration: BoxDecoration(
                                      //             color:
                                      //                 const Color(0xffF6F6F6),
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     10)),
                                      //         child: Padding(
                                      //           padding:
                                      //               const EdgeInsets.symmetric(
                                      //                   horizontal: 16,
                                      //                   vertical: 10),
                                      //           child: Column(
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               const Row(
                                      //                 children: [],
                                      //               ),
                                      //               Text(
                                      //                 data['notes'],
                                      //                 style: const TextStyle(
                                      //                     fontSize: 10,
                                      //                     fontWeight:
                                      //                         FontWeight.w500),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text(
                                            'Current Status :',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: primaryColor),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            data['status'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    data['status'] == 'Rejected'
                                                        ? Colors.red
                                                        : data['status'] ==
                                                                'Pending'
                                                            ? const Color(
                                                                0xffEDC161)
                                                            : primaryColor),
                                          ),
                                        ],
                                      )
                                    ])));
                          });
                    }
                  }),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> addLeaveRequest() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              content: StatefulBuilder(builder: (context, setState) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Select type',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),

                          /// There will be a dropdown later

                          Container(
                            height: 50,
                            decoration: BoxDecoration(color: white, boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.15),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: const Offset(-1, -1))
                            ]),
                            child: DropdownButtonFormField2<String>(
                              items: leaveList
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  leaveSelectedValue = value;
                                });
                              },
                              isExpanded: true,
                              value: leaveSelectedValue,
                              hint: const Text(
                                'select',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: hideTextColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 16),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Select date for leave',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFieldWidget(
                                      controller: fromController,
                                      readOnly: true,
                                      sufixIcon: GestureDetector(
                                        onTap: () {
                                          startDatePicker(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Image.asset(
                                              'assets/images/calander.png',
                                              height: 10,
                                              width: 10),
                                        ),
                                      ),
                                      horizontalPadding: 5,
                                      hintText: 'Select Date')
                                ],
                              )),
                              // Expanded(
                              //     flex: 2,
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         const Text(
                              //           'From',
                              //           style: TextStyle(
                              //               fontSize: 10,
                              //               fontWeight: FontWeight.w500),
                              //         ),
                              //         const SizedBox(
                              //           height: 8,
                              //         ),
                              //         TextFieldWidget(
                              //             controller: fromController,
                              //             readOnly: true,
                              //             sufixIcon: GestureDetector(
                              //               onTap: () {
                              //                 startDatePicker(context);
                              //               },
                              //               child: Padding(
                              //                 padding: const EdgeInsets.all(16),
                              //                 child: Image.asset(
                              //                     'assets/images/calander.png',
                              //                     height: 10,
                              //                     width: 10),
                              //               ),
                              //             ),
                              //             horizontalPadding: 5,
                              //             hintText: 'Start Date')
                              //       ],
                              //     )),
                              // const SizedBox(
                              //   width: 20,
                              // ),
                              // Expanded(
                              //     flex: 2,
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         const Text(
                              //           'To',
                              //           style: TextStyle(
                              //               fontSize: 10,
                              //               fontWeight: FontWeight.w500),
                              //         ),
                              //         const SizedBox(
                              //           height: 8,
                              //         ),
                              //         TextFieldWidget(
                              //             readOnly: true,
                              //             sufixIcon: GestureDetector(
                              //               onTap: () {
                              //                 endDatePicker(context);
                              //               },
                              //               child: Padding(
                              //                 padding: const EdgeInsets.all(16),
                              //                 child: Image.asset(
                              //                     'assets/images/calander.png',
                              //                     height: 10,
                              //                     width: 10),
                              //               ),
                              //             ),
                              //             horizontalPadding: 5,
                              //             controller: toController,
                              //             hintText: 'End Date')
                              //       ],
                              //     ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const CustomText(
                            text: 'Type Reason',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MultiLineTextFieldWidget(
                              controller: reasonController, maxLines: 8),

                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonComp(
                                title: 'Cancel',
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                backColor: white,
                                bordeRadius: 0,
                                borderColor: borderColor,
                                textColor: borderColor,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ButtonComp(
                                title: 'Send',
                                onTap: () async {
                                  String? myToken = await notificationServices
                                      .getDeviceToken();

                                  DateTime currentDate = DateTime.now();
                                  String currentFormatedDate =
                                      DateFormat('dd MMMM, yyyy')
                                          .format(currentDate);
                                  User? currentUser =
                                      FirebaseAuth.instance.currentUser;
                                  String userId = currentUser!.uid;

                                  DocumentSnapshot userSnapshot =
                                      await FirebaseFirestore.instance
                                          .collection('employees')
                                          .doc(userId)
                                          .get();

                                  String name = userSnapshot.get('name');
                                  String image = userSnapshot.get('image');
                                  String team = userSnapshot.get('team');

                                  if (leaveSelectedValue == null ||
                                      fromController.text.toString() == "" ||
                                      // toController.text.toString() == "" ||
                                      reasonController.text.toString() == "") {
                                    Fluttertoast.showToast(
                                        msg: 'Error: Please fill all fields');
                                  } else {
                                    
                                    var id =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    FirebaseFirestore.instance
                                        .collection('notifications')
                                        .doc(id)
                                        .set({
                                      'title': "Request For Leave",
                                      'isRead': false,
                                      'receiveToken': myToken,
                                      'userId': id,
                                      'currentDate': currentFormatedDate,
                                      'name': name,
                                      'team':team,
                                      "notificationType": "leaveRequest",
                                      'image': image,
                                    }).then((value) {
                                      FirebaseFirestore.instance
                                          .collection('leaveRequests')
                                          .doc(id)
                                          .set({
                                        'leaveSelectedValue':
                                            leaveSelectedValue,
                                        'leaveDate':
                                            fromController.text.toString(),
                                        'desc':
                                            reasonController.text.toString(),
                                        'status': 'Pending',
                                        'isRead': false,
                                        'receiveToken': myToken,
                                        'userId': id,
                                        'currentDate': currentFormatedDate,
                                        'name': name,
                                        'image': image,
                                        'notes': '',
                                        'team': team,
                                      }).then((value) {
                                        sendNotification(
                                            leaveSelectedValue.toString());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Successfully Send')));
                                      }).onError((error, stackTrace) {});

                                      fromController.clear();
                                      toController.clear();
                                      reasonController.clear();

                                      Navigator.pop(context);
                                    }).onError((error, stackTrace) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Failed $error.toString()')));
                                      Navigator.pop(context);
                                    }).then((value) {
                                      DateTime now = DateTime.now();
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd').format(now);

                                      DateTime currentMY = DateTime.now();

                                      myformattedMY =
                                          formatMonthAndYear(currentMY);
                                      DateTime currentTime = DateTime.now();
                                      int unixTimestamp =
                                          currentTime.millisecondsSinceEpoch ~/
                                              1000;
                                      // FirebaseFirestore.instance
                                      //     .collection('checkInOut')
                                      //     .doc()
                                      //     .set({
                                      //   'checkInTime': '00:00',
                                      //   'date': formattedDate,
                                      //   'checkOutTime': '00:00',
                                      //   'currentUserId': _auth.currentUser?.uid,
                                      //   'currentMY': myformattedMY,
                                      //   'isPresent': false,
                                      //   'isAbsent': true,
                                      //   'isLeave': false,
                                      //   'unixTimestamp': unixTimestamp,
                                      // });
                                    });
                                  }
                                },
                                backColor: primaryColor,
                                bordeRadius: 0,
                                textColor: white,
                              ),
                            ],
                          )
                        ]),
                  ),
                );
              }));
        });
  }
}


// import 'package:elabd_ems_admin/helper/import_helper.dart';
// import 'package:elabd_ems_admin/view/notifications/components/leave_request_card.dart';
// import '../../model/notification_model.dart';
// class LeaveRequest extends StatelessWidget {
//   final List<NotificationModel> notifications;
//   const LeaveRequest({super.key, required this.notifications});
//   @override
//   Widget build(BuildContext context) {
//     MySize().init(context);
//     return Scaffold(
//       appBar: const AppBarWidget(title: 'Leave Requests'),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: MySize.size16),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: MySize.size20,
//               ),
//               ListView.separated(
//                   separatorBuilder: (context, index) => SizedBox(
//                         height: MySize.size15,
//                       ),
//                   itemCount: notifications.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return LeaveRequestCard(
//                       date: notifications[index].currentDate,
//                       desc: notifications[index].desc,
//                       image: notifications[index].image,
//                       name: notifications[index].name,
//                       // role: notifications[index].role,
//                     );
//                   })
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
