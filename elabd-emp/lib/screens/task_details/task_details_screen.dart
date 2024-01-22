import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/custom_button.dart';
import 'package:elabd_tms_app/components/custom_text.dart';
import 'package:elabd_tms_app/screens/task_details/task_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../components/custom_app_bar.dart';
import '../../constants/colors.dart';

// ignore: must_be_immutable
class TaskDetailScreen extends StatefulWidget {
  Map<String, dynamic> task;

  TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  int? selectedRadio = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(' My Task Information ${widget.task}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Task Details",
        backgroundColor: Colors.white,
        textColor: black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Consumer<TaskDetailsProvider>(
          builder: (context, provider, _) => StreamBuilder<
                  Map<String, dynamic>>(
              stream: provider.detailtaskData(widget.task),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final task = snapshot.data!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: "Sign Date: ",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                    color: black,
                                  ),
                                  CustomText(
                                    text: task['startDate'],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                    color: halfSilverColor,
                                  )
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  CustomText(
                                    text: "Current Status: ",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                    color: black,
                                  ),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('tasks')
                                          .doc(widget.task['taskId'])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Text('No Data Found');
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else {
                                          Map<String, dynamic> data =
                                              snapshot.data!.data()
                                                  as Map<String, dynamic>;

                                          return CustomText(
                                            text: data["taskStatus"],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.sp,
                                            color: primaryColor,
                                          );
                                        }
                                      })
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            padding: const EdgeInsets.all(20).r,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10).r,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: task['taskDetail'],
                                  fontSize: 12.sp,
                                  color: black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 80.h,
                                  width: MediaQuery.sizeOf(context).width,
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Row(
                                      children: [
                                        CustomText(
                                          fontSize: 12.sp,
                                          color: primaryColor,
                                          text: "Current Status:",
                                        ),
                                        SizedBox(width: 5.w),
                                        StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('tasks')
                                                .doc(widget.task['taskId'])
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Text(
                                                    'No Data Found');
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              } else {
                                                Map<String, dynamic> data =
                                                    snapshot.data!.data()
                                                        as Map<String, dynamic>;

                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    CustomText(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: primaryColor,
                                                      text: data['taskStatus'],
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    data['taskStatus'] ==
                                                            'Completed'
                                                        ? const SizedBox(
                                                            height: 0,
                                                            width: 0,
                                                          )
                                                        : CustomButton(
                                                            fontSize: 12.sp,
                                                            width: 100.w,
                                                            height: 35.h,
                                                            text:
                                                                "Change Status",
                                                            textColor:
                                                                Colors.white,
                                                            color: primaryColor,
                                                            onPressed: () {
                                                              dialogShow(
                                                                  context,
                                                                  task);
                                                            },
                                                          ),
                                                  ],
                                                );
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  void dialogShow(BuildContext context, Map<String, dynamic> task) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Consumer<TaskDetailsProvider>(
                builder: (context, provider, _) => SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Change Status",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: black,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<int?>(
                                    value: 1,
                                    groupValue: provider.selectedButton,
                                    onChanged: (value) {
                                      provider.setSelectedButton(value!);
                                    },
                                  ),
                                  CustomText(
                                    text: 'Completed',
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                ],
                              ),
                            ),
                            // Expanded(
                            //   child: Row(
                            //     children: [
                            //       Radio<int?>(
                            //         value: 2,
                            //         groupValue: provider.selectedButton,
                            //         onChanged: (value) {
                            //           provider.setSelectedButton(value!);
                            //         },
                            //       ),
                            //       CustomText(
                            //         text: 'On Hold',
                            //         fontSize: 10.sp,
                            //         fontWeight: FontWeight.w500,
                            //         color: black,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        // const SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           Radio<int?>(
                        //             value: 3,
                        //             groupValue: provider.selectedButton,
                        //             onChanged: (value) {
                        //               provider.setSelectedButton(value!);
                        //             },
                        //           ),
                        //           CustomText(
                        //             text: 'Closed',
                        //             fontSize: 10.sp,
                        //             fontWeight: FontWeight.w500,
                        //             color: black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           Radio<int?>(
                        //             value: 4,
                        //             groupValue: provider.selectedButton,
                        //             onChanged: (value) {
                        //               provider.setSelectedButton(value!);
                        //             },
                        //           ),
                        //           CustomText(
                        //             text: 'ReOpen',
                        //             fontSize: 10.sp,
                        //             fontWeight: FontWeight.w500,
                        //             color: black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           Radio<int?>(
                        //             value: 5,
                        //             groupValue: provider.selectedButton,
                        //             onChanged: (value) {
                        //               provider.setSelectedButton(value!);
                        //             },
                        //           ),
                        //           CustomText(
                        //             text: 'Fixed',
                        //             fontSize: 10.sp,
                        //             fontWeight: FontWeight.w500,
                        //             color: black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           Radio<int?>(
                        //             value: 6,
                        //             groupValue: provider.selectedButton,
                        //             onChanged: (value) {
                        //               provider.setSelectedButton(value!);
                        //             },
                        //           ),
                        //           CustomText(
                        //             text: 'Transfered',
                        //             fontSize: 10.sp,
                        //             fontWeight: FontWeight.w500,
                        //             color: black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           Radio<int?>(
                        //             value: 7,
                        //             groupValue: provider.selectedButton,
                        //             onChanged: (value) {
                        //               provider.setSelectedButton(value!);
                        //             },
                        //           ),
                        //           CustomText(
                        //             text: 'New',
                        //             fontSize: 10.sp,
                        //             fontWeight: FontWeight.w500,
                        //             color: black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           Radio<int?>(
                        //             value: 8,
                        //             groupValue: provider.selectedButton,
                        //             onChanged: (value) {
                        //               provider.setSelectedButton(value!);
                        //             },
                        //           ),
                        //           CustomText(
                        //             text: 'Work Started',
                        //             fontSize: 10.sp,
                        //             fontWeight: FontWeight.w500,
                        //             color: black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  print(provider.selectedButton);
                                  if (provider.selectedButton == 1) {
                                    provider
                                        .changeStatus(task, "Completed")
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                    Navigator.pop(context);
                                  }
                                  // else if (provider.selectedButton == 2) {
                                  //   provider
                                  //       .changeStatus(task, "On Hold")
                                  //       .whenComplete(
                                  //           () => Navigator.pop(context));
                                  // } else if (provider.selectedButton == 3) {
                                  //   provider
                                  //       .changeStatus(task, "Closed")
                                  //       .whenComplete(
                                  //           () => Navigator.pop(context));
                                  // } else if (provider.selectedButton == 4) {
                                  //   provider
                                  //       .changeStatus(task, "ReOpen")
                                  //       .whenComplete(
                                  //           () => Navigator.pop(context));
                                  // } else if (provider.selectedButton == 5) {
                                  //   provider
                                  //       .changeStatus(task, "Fixed")
                                  //       .whenComplete(
                                  //           () => Navigator.pop(context));
                                  // } else if (provider.selectedButton == 6) {
                                  //   provider
                                  //       .changeStatus(task, "Transfered")
                                  //       .whenComplete(
                                  //           () => Navigator.pop(context));
                                  // } else if (provider.selectedButton == 7) {
                                  //   provider
                                  //       .changeStatus(task, "New")
                                  //       .whenComplete(
                                  //           () => Navigator.pop(context));
                                  // } else if (provider.selectedButton == 8) {
                                  //   provider
                                  //       .changeStatus(task, "Work Started")
                                  //       .whenComplete(
                                  //           () => Navigator.pop(context));
                                  // }
                                  else {
                                    print('Error While updating task');
                                  }
                                },
                                child: const Text('Yes')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
