// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/core/multi_line_textfield_widget.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class LeaveRequestCard extends StatelessWidget {
  final String? image;
  final String? name;
  // final String? role;
  final String? date;
  final String? desc;
  final String? status;
  final String? documentId;
  final String? currentUserId;
  final String? team;
  final String? leaveDate;

  LeaveRequestCard({
    super.key,
    this.image,
    this.leaveDate,
    this.team,
    this.name,
    this.date,
    this.desc,
    this.status,
    this.documentId,
    this.currentUserId,
  });

  final notesTextFieldController = TextEditingController();
  // Future<void> updateStatus(String documentId, String newStatus) async {
  //   await FirebaseFirestore.instance
  //       .collection('notifications')
  //       .doc(documentId) // Use the passed document ID
  //       .update({'status': newStatus});
  // }

  Future<void> updateStatusAndSendNotification(BuildContext context,
      {required String documentId,
      required String leaveDate,
      required String currentDate,
      required String currentUserId,
      required String newStatus,
      required String notes}) async {
    if (newStatus == "Rejected") {
      await FirebaseFirestore.instance
          .collection('leaveRequests')
          .doc(documentId)
          .update({
        'status': newStatus,
        'notes': notes
      }); // Update status and add notes
      getFlushBar(context,
          title: "Leave Rejected Successfully",
          color: primaryColor,
          isSuccess: true);
      // Send a notification to the user with the added notes
      sendNotificationToUser(documentId, "Leave Rejected Successfully");
    } else {
      final snapshot =
          await FirebaseFirestore.instance.collection('checkInOut').get();

      final snapshotList = snapshot.docs
          .where((e) =>
              e.get('currentUserId') == currentUserId &&
              e.get("date") == leaveDate)
          .toList();
      print(snapshotList.length);
      if (snapshotList.isEmpty) {
        print("leave date available");
        await FirebaseFirestore.instance.collection('checkInOut').doc().set({
          'checkInTime': '00:00',
          'checkOutTime': '00:00',
          'currentMY': date,
          'currentUserId': currentUserId,
          'date': leaveDate,
          'isPresent': false,
          'isAbsent': false,
          'isLeave': true,
          'unixTimestamp': 0
        });
        await FirebaseFirestore.instance
            .collection('leaveRequests')
            .doc(documentId)
            .update({
          'status': newStatus,
          'notes': notes
        }); // Update status and add notes
        getFlushBar(context,
            title: "Leave Marked Successfully",
            color: primaryColor,
            isSuccess: true);
        // Send a notification to the user with the added notes
        sendNotificationToUser(documentId, "Leave Marked Successfully");
      } else {
        print("leave Already Exist");

        await FirebaseFirestore.instance
            .collection('leaveRequests')
            .doc(documentId)
            .update({
          'status': "Rejected",
          'notes': notes
        }); // Update status and add notes

        getFlushBar(context,
            title: "Leave Already Exist",
            color: primaryColor,
            isSuccess: false);
        // Send a notification to the user with the added notes
        sendNotificationToUser(documentId, "Leave Already Exist");
      }

      // await FirebaseFirestore.instance
      //     .collection('notifications')
      //     .doc(documentId)
      //     .update({'status': newStatus, 'notes': notes});
      // await FirebaseFirestore.instance
      //     .collection('leaveRequests')
      //     .doc(documentId)
      //     .update({
      //   'status': newStatus,
      //   'notes': notes
      // }); // Update status and add notes

      // // Send a notification to the user with the added notes
      // sendNotificationToUser(documentId, notes);
    }
  }

  Future<void> sendNotificationToUser(String documentId, String notes) async {
    // Fetch the user's token from the document ID
    final notificationData =
        await FirebaseFirestore.instance.collection('notifications').doc(documentId).get();
    // final data=notificationData.docs.where((element) => element['userId']==currentUserId && element['notificationType']=="leaveRequest" && );

    String userToken = notificationData['receiveToken'];
    final data = {
      'registration_ids': [userToken],
      'priority': 'high',
      'notification': {'title': 'New Message', 'body': notes}
    };

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
      debugPrint('Notification sent successfully');
    } else {
      debugPrint('Error sending notification: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('This is Current User Id ${currentUserId}');
    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(MySize.size10),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(2, 2),
                color: blackColor.withOpacity(0.10))
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MySize.size15, vertical: MySize.size8),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(MySize.size50),
                  child: CachedNetworkImage(
                    imageUrl: image!,
                    height: MySize.size44,
                    width: MySize.size44,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(strokeWidth: 2),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                  // Image.network(
                  //   image!,
                  //   height: MySize.size44,
                  //   width: MySize.size44,
                  //   fit: BoxFit.fill,
                  // )
                  ),
              SizedBox(
                width: MySize.size10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MySize.size6,
                    ),
                    Text(
                      name!,
                      style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                    ),
                    Text(
                      team!,
                      style: poppineRegular.copyWith(
                          color: primaryColor, fontSize: MySize.size10),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(
                date!,
                style: poppineRegular.copyWith(
                    fontSize: MySize.size10, color: primaryColor),
              ),
            ],
          ),
          SizedBox(
            height: MySize.size10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: MySize.size8),
            decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(MySize.size10)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MySize.size16, vertical: MySize.size10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [],
                  ),
                  Text(
                    desc!,
                    style: poppineRegular.copyWith(fontSize: MySize.size10),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MySize.size16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showActionDialog(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                      child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      'Approve/Decline',
                      style: poppinMedium.copyWith(
                          color: whiteColor, fontSize: MySize.size12),
                    ),
                  )),
                ),
              ),
            ],
          ),

          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         showAddNotDialog(context);
          //       },
          //       child: Padding(
          //         padding: EdgeInsets.all(MySize.size4),
          //         child: Text(
          //           'Add Note',
          //           style: poppinMedium.copyWith(
          //               fontSize: MySize.size10, color: primaryColor),
          //         ),
          //       ),
          //     ),
          //     const Spacer(),
          //     ButtonComp(
          //       title: 'Accept',
          //       onTap: () {
          //         updateStatus(documentId!, 'Accepted').then((value) {
          //           getFlushBar(context,
          //               title: "Successfully Accepted", color: primaryColor);
          //         });
          //       },
          //     ),
          //     SizedBox(
          //       width: MySize.size14,
          //     ),
          //     ButtonComp(
          //       title: 'Reject',
          //       onTap: () {
          //         updateStatus(documentId!, 'Rejected').then((value) {
          //           getFlushBar(context,
          //               title: 'Successfully Rejected', color: primaryColor);
          //         });
          //       },
          //       backColor: redColor,
          //     )
          //   ],
          // ),

          SizedBox(
            height: MySize.size8,
          ),
        ]),
      ),
    );
  }

  Future<void> showActionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: ShapeDecoration(
                  color: whiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size8))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Note',
                      style: poppineRegular.copyWith(fontSize: MySize.size12),
                    ),
                    SizedBox(
                      height: MySize.size14,
                    ),
                    MultiLineTextFieldWidget(
                      controller: notesTextFieldController,
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: MySize.size20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (notesTextFieldController.text.isEmpty) {
                                getFlushBar(context, title: "Please add notes");
                              } else {
                                SmartDialog.showLoading();
                                updateStatusAndSendNotification(context,
                                        documentId: documentId!,
                                        newStatus: 'Rejected',
                                        notes: notesTextFieldController.text
                                            .toString(),
                                        currentDate: date!,
                                        currentUserId: currentUserId!,
                                        leaveDate: leaveDate!)
                                    .then((value) {
                                  // getFlushBar(context,
                                  //     title:
                                  //         "Notification Send Back Successfully",
                                  //     color: primaryColor,
                                  //     isSuccess: true);
                                  // getFlushBar(context,
                                  //     title: "Leave Rejected Successfully",
                                  //     color: primaryColor,
                                  //     isSuccess: true);
                                  SmartDialog.dismiss();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarView(
                                                index: 0,
                                              )));
                                }).onError((error, stackTrace) {
                                  SmartDialog.dismiss();
                                  getFlushBar(context, title: 'Error $error');
                                }).then((value) {});
                              }
                            },
                            child: const Text('Reject')),
                        TextButton(
                            onPressed: () {
                              if (notesTextFieldController.text.isEmpty) {
                                getFlushBar(context, title: 'Please add notes');
                              } else {
                                SmartDialog.showLoading();
                                updateStatusAndSendNotification(
                                  context,
                                  documentId: documentId!,
                                  newStatus: 'Accepted',
                                  leaveDate: leaveDate!,
                                  currentDate: date!,
                                  currentUserId: currentUserId!,
                                  notes:
                                      notesTextFieldController.text.toString(),
                                ).then((value) {
                                SmartDialog.dismiss();
                                  // getFlushBar(context,
                                  //     title:
                                  //         "Notification Send Back Successfully",
                                  //     color: primaryColor,
                                  //     isSuccess: true);
                                  // getFlushBar(context,
                                  //     title: "Leave update send Successfully",
                                  //     color: primaryColor,
                                  //     isSuccess: true);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarView(
                                                index: 0,
                                              )));
                                }).onError((error, stackTrace) {
                                  SmartDialog.dismiss();
                                  getFlushBar(context,
                                      title: 'Error::: $error');
                                });
                                // .then((value) {
                                //   // FirebaseFirestore.instance
                                //   //     .collection('checkInOut')
                                //   //     .doc(currentUserId)
                                //   //     .update({
                                //   //   'isPresent': false,
                                //   //   'isAbsent': false,
                                //   //   'isLeave': true,
                                //   // });
                                // });
                              }
                            },
                            child: const Text('Accept')),
                        // ButtonComp(
                        //   title: 'Reject',
                        //   onTap: () {
                        //     if (notesTextFieldController.text.isEmpty) {
                        //       getFlushBar(context, title: "Please add notes");
                        //     } else {
                        //       updateStatusAndSendNotification(
                        //         documentId!,
                        //         'Rejected',
                        //         notesTextFieldController.text.toString(),
                        //       ).then((value) {
                        //         Navigator.pop(context);
                        //         getFlushBar(context,
                        //             title:
                        //                 "Notification Send Back Successfully",
                        //             color: primaryColor,
                        //             isSuccess: true);
                        //       }).onError((error, stackTrace) {
                        //         getFlushBar(context, title: 'Error $error');
                        //       });
                        //     }
                        //   },
                        //   backColor: whiteColor,
                        //   bordeRadius: 0,
                        //   textColor: borderColor,
                        //   borderColor: borderColor,
                        // ),
                        // ButtonComp(
                        //   title: 'Accept',
                        //   onTap: () {
                        //     if (notesTextFieldController.text.isEmpty) {
                        //       getFlushBar(context, title: 'Please add notes');
                        //     } else {
                        //       updateStatusAndSendNotification(
                        //         documentId!,
                        //         'Accepted',
                        //         notesTextFieldController.text.toString(),
                        //       ).then((value) {
                        //         getFlushBar(context,
                        //             title:
                        //                 "Notification Send Back Successfully",
                        //             color: primaryColor,
                        //             isSuccess: true);
                        //         Navigator.pop(context);
                        //       }).onError((error, stackTrace) {
                        //         getFlushBar(context, title: 'Error $error');
                        //       });
                        //     }
                        //   },
                        //   backColor: primaryColor,
                        //   bordeRadius: 0,
                        //   textColor: whiteColor,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
