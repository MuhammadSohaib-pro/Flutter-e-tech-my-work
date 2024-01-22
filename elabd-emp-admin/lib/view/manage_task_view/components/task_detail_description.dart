import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/core/multi_line_textfield_widget.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

class TaskDetailDescription extends StatefulWidget {
  final String? title;
  final String? desc;
  final String? status;
  final String? taskId;
  final String? assignedUserId;
  const TaskDetailDescription(
      {super.key,
      this.desc,
      this.status,
      this.taskId,
      this.title,
      this.assignedUserId});

  @override
  State<TaskDetailDescription> createState() => _TaskDetailDescriptionState();
}

class _TaskDetailDescriptionState extends State<TaskDetailDescription> {
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  final descriptionController = TextEditingController();
  int selectedRadio = 0;
  String? selectedRadioValue;

  List<String> radioOptions = [
    'Completed',
    'Finished',
    'Assigned',
    'OnHold',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(MySize.size10),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.10),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(2, 2),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [],
              ),
              SizedBox(
                height: MySize.size10,
              ),
              Text(
                widget.title.toString(),
                style: poppinMedium.copyWith(
                    color: blackColor, fontSize: MySize.size14),
              ),
              SizedBox(
                height: MySize.size6,
              ),
              Text(
                'Discription',
                style: poppinMedium.copyWith(
                    color: lightGrey, fontSize: MySize.size10),
              ),
              SizedBox(
                height: MySize.size16,
              ),
              Text(
                'Test Task by Elabd Tech',
                style: poppinBold.copyWith(fontSize: MySize.size16),
              ),
              SizedBox(
                height: MySize.size8,
              ),
              Text(
                // loremText,
                widget.desc.toString(),
                style: poppinMedium.copyWith(fontSize: MySize.size10),
              ),
              SizedBox(
                height: MySize.size10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(MySize.size10),
                    boxShadow: [
                      BoxShadow(
                        color: blackColor.withOpacity(0.10),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(2, 2),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text(
                      'Current Status',
                      style: poppineRegular.copyWith(
                          color: primaryColor, fontSize: MySize.size12),
                    ),
                    SizedBox(
                      width: MySize.size10,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(widget.taskId)
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('No Data Found');
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return Row(
                              children: [
                                Text(
                                  // This will be from firebase
                                  data['taskStatus'],
                                  // 'Assigned',
                                  style: poppinBold.copyWith(
                                      color: primaryColor,
                                      fontSize: MySize.size12),
                                ),
                                SizedBox(
                                  width: MySize.size30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    changeStatusDialog(
                                        context, data['taskStatus']);
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: primaryColor),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MySize.size6,
                                          vertical: MySize.size5),
                                      child: Text(
                                        'Change Status',
                                        style: poppinMedium.copyWith(
                                            color: whiteColor,
                                            fontSize: MySize.size12),
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            );
                          }
                        })),

                    // Text(
                    //   // This will be from firebase
                    //   widget.status!,
                    //   // 'Assigned',
                    //   style: poppinBold.copyWith(
                    //       color: primaryColor, fontSize: MySize.size12),
                    // ),
                  ]),
                ),
              ),
              SizedBox(
                height: MySize.size10,
              ),
            ],
          ),
        ));
  }

  Future<void> sendNotification(String message, String sendEmployeId) async {
    final deviceTokenSnapshot = await FirebaseFirestore.instance
        .collection('employees')
        .doc(sendEmployeId)
        .get();

    final deviceToken = deviceTokenSnapshot.data()?['fcmToken'];

    if (deviceToken != null) {
      final data = {
        'to': deviceToken,
        'priority': 'high',
        'notification': {
          'title': deviceTokenSnapshot.data()?['name'],
          'body': message
        }
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
    } else {
      debugPrint('Recipient device token not found');
    }
  }

  Future<void> updateTask(
      {required String documentId,
      required String newTaskStatus,
      required String newTaskDesc}) async {
    SmartDialog.showLoading();
    // Reference to the document you want to update
    DocumentReference taskRef =
        FirebaseFirestore.instance.collection('tasks').doc(documentId);

    try {
      await taskRef.update({
        'taskStatus': newTaskStatus,
      });
      SmartDialog.dismiss();
      getFlushBar(context,
          title: 'Task updated successfully.',
          color: primaryColor,
          isSuccess: true);
      sendNotification('Task Update', widget.assignedUserId!);
    } catch (e) {
      SmartDialog.dismiss();
      getFlushBar(context, title: 'Error updating task: $e');
    }
  }

  Future<void> changeStatusDialog(
      BuildContext context, String initialStatus) async {
    return await showDialog(
      context: context,
      builder: (context) {
        int selectedRadio = radioOptions.indexOf(initialStatus);

        // String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MySize.size8)),
              child: Container(
                padding: EdgeInsets.all(MySize.size25),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MySize.size8)),
                    color: whiteColor),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Change Status",
                        style: poppineRegular.copyWith(fontSize: MySize.size12),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 0.2,
                        ),
                        itemCount: radioOptions.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Radio(
                                value: index,
                                groupValue: selectedRadio,
                                activeColor: primaryColor,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (value) {
                                  setState(() {
                                    selectedRadio = value!;
                                    // Print the selected radio option from the radioOptions list
                                    debugPrint(
                                        'Selected Option: ${radioOptions[selectedRadio]}');
                                    selectedRadioValue =
                                        radioOptions[selectedRadio];
                                    debugPrint(selectedRadioValue);
                                  });
                                },
                              ),
                              Text(
                                radioOptions[index],
                                style: poppinMedium.copyWith(
                                    fontSize: MySize.size10),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: MySize.size10,
                      ),
                      Text(
                        "Add Description",
                        style: poppineRegular.copyWith(fontSize: MySize.size12),
                      ),
                      SizedBox(
                        height: MySize.size10,
                      ),
                      MultiLineTextFieldWidget(
                        controller: descriptionController,
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cencle')),
                          TextButton(
                              onPressed: () async {
                                if (descriptionController.text.isEmpty) {
                                  getFlushBar(context,
                                      title: 'Please provide a description');
                                } else {
                                  await updateTask(
                                          newTaskDesc: descriptionController
                                              .text
                                              .toString(),
                                          documentId: widget.taskId!,
                                          newTaskStatus: selectedRadioValue!)
                                      .then((value) {
                                    setState(() {});
                                    descriptionController.clear();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contect) =>
                                                BottomNavigationBarView(
                                                  index: 2,
                                                )));
                                  });
                                }
                              },
                              child: const Text('Yes')),
                          // ButtonComp(
                          //     borderColor: borderColor,
                          //     textColor: lightGrey,
                          //     title: 'Cancel',
                          //     onTap: () {
                          //       Navigator.pop(context);
                          //     },
                          //     bordeRadius: 0,
                          //     backColor: whiteColor),
                          // ButtonComp(
                          //     title: 'Yes',
                          //     onTap: () async {
                          //       if (descriptionController.text.isEmpty) {
                          //         getFlushBar(context,
                          //             title: 'Please provide a description');
                          //       } else {
                          //         await updateTask(
                          //                 newTaskDesc: descriptionController
                          //                     .text
                          //                     .toString(),
                          //                 documentId: widget.taskId!,
                          //                 newTaskStatus: selectedRadioValue!)
                          //             .then((value) {
                          //           setState(() {});
                          //           descriptionController.clear();
                          //         });
                          //       }
                          //     },
                          //     bordeRadius: 0),
                        ],
                      )
                    ]),
              ),
            );
          },
        );
      },
    );
  }
}
