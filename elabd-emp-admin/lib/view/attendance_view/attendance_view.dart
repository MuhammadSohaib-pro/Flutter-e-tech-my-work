// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/model/attendance_model.dart';
import 'package:elabd_ems_admin/providers/attendance_provider.dart';
import 'package:elabd_ems_admin/services/internet_check.dart';
import 'package:elabd_ems_admin/view/attendance_view/components/absent_leave_card.dart';
import 'package:elabd_ems_admin/view/attendance_view/components/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  final taskController = TextEditingController();

  Future selectTaskDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null) {
      taskController.text =
          '${picked.day <= 9 && picked.day >= 1 ? '0${picked.day}' : picked.day}-${picked.month}-${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('yyyy-MM-dd').format(DateTime.now());
    List<QueryDocumentSnapshot> employeeList = [];

    List<AttendanceModel> checkInOutList = [];
    getAttendanceData(data) async {
      try {
        SmartDialog.showLoading();
        List<AttendanceModel> overAllData = [];
        employeeList.clear();
        checkInOutList.clear();
        employeeList.addAll(data.where((element) =>
            element['role'] == "user" && element['status'] == 'Active'));

        final provider =
            Provider.of<AttendanceProvider>(context, listen: false);
        provider.clearCheckInOutList();
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection("checkInOut").get();
        final allData = querySnapshot.docs.toList();
        for (var e in allData) {
          if (e['date'] == time) {
            checkInOutList.add(AttendanceModel(
                checkInTime: e['checkInTime'],
                checkOutTime: e['checkOutTime'],
                currentMY: e['currentMY'],
                currentUserId: e['currentUserId'],
                date: e['date'],
                isAbsent: e['isAbsent'],
                isLeave: e['isLeave'],
                isPresent: e['isPresent'],
                unixTimestamp: e['unixTimestamp']));
          }
        }

        for (var i = 0; i < employeeList.length; i++) {
          var documentId = employeeList[i]['id'];
          var found = -1;
          for (var j = 0; j < checkInOutList.length; j++) {
            if (checkInOutList[j].currentUserId == documentId) {
              found = j;
              break;
            }
          }
          if (found == -1) {
            overAllData.add(AttendanceModel(
                checkInTime: '',
                checkOutTime: '',
                currentMY: '',
                currentUserId: employeeList[i]['id'],
                date: '',
                isAbsent: false,
                isLeave: false,
                isPresent: false,
                unixTimestamp: 0,
                name: employeeList[i]['name'],
                image: employeeList[i]['image']));
          } else {
            overAllData.add(AttendanceModel(
                checkInTime: checkInOutList[found].checkInTime,
                checkOutTime: checkInOutList[found].checkOutTime,
                currentMY: checkInOutList[found].currentUserId,
                currentUserId: checkInOutList[found].currentUserId,
                date: checkInOutList[found].date,
                isAbsent: checkInOutList[found].isAbsent,
                isLeave: checkInOutList[found].isLeave,
                isPresent: checkInOutList[found].isPresent,
                unixTimestamp: checkInOutList[found].unixTimestamp,
                name: employeeList[i]['name'],
                image: employeeList[i]['image']));
          }
        }

        print(overAllData.length);
        provider.setCheckInOutList(overAllData);
        SmartDialog.dismiss();
      } catch (e) {
        SmartDialog.dismiss();
        print('Error ::: $e');
      }
    }

    MySize().init(context);
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Attendance',
        isLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: Column(
          children: [
            SizedBox(
              height: MySize.size20,
            ),
            TextFieldWidget(
              controller: taskController,
              readOnly: true,
              hintText:
                  '${DateTime.now().day <= 9 && DateTime.now().day >= 1 ? '0${DateTime.now().day}' : DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
              sufixIcon: Padding(
                padding: EdgeInsets.all(MySize.size15),
                child: GestureDetector(
                  onTap: () {
                    selectTaskDate(context);
                  },
                  child: Image.asset(
                    AppIcons.calander,
                    height: MySize.size15,
                    width: MySize.size15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: () async {
            //       print("object");
            //       SmartDialog.showLoading();
            //       await multipleCheckOutAtOnce();
            //     },
            //     child: Container(
            //         height: 40,
            //         width: 90,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           color: primaryColor,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: const Text(
            //           'Multiple Checkout',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             color: whiteColor,
            //             fontSize: 11,
            //           ),
            //         )),
            //   ),
            // ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('employees')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData) {
                      return const Text('No data found ');
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Text('No data found of the current user');
                    } else if (snapshot.hasError) {
                      return Text('Error ${snapshot.hasError}');
                    } else {
                      getAttendanceData(snapshot.data!.docs);

                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: MySize.size12),
                        itemCount: employeeList.length,
                        itemBuilder: (context, index) =>
                            Consumer<AttendanceProvider>(
                          builder: (context, provider, child) =>
                              provider.checkInOutList.isNotEmpty
                                  ? Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius: BorderRadius.circular(
                                              MySize.size10),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10,
                                              spreadRadius: 0,
                                              offset: const Offset(2, 2),
                                              color:
                                                  blackColor.withOpacity(0.10),
                                            )
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: MySize.size10),

                                                  Material(
                                                    elevation: 3.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor:
                                                          Colors.grey.shade200,
                                                      backgroundImage:
                                                          NetworkImage(provider
                                                              .checkInOutList[
                                                                  index]
                                                              .image!),
                                                    ),
                                                  ),

                                                  // CachedNetworkImage(
                                                  //   imageUrl: provider
                                                  //       .checkInOutList[index]
                                                  //       .image!,
                                                  //   height: MySize.size44,
                                                  //   width: MySize.size44,
                                                  //   fit: BoxFit.cover,
                                                  //   placeholder: (context, url) =>
                                                  //       const CircularProgressIndicator(
                                                  //           strokeWidth: 2),
                                                  //   errorWidget: (context, url,
                                                  //           error) =>
                                                  //       const Icon(Icons.error),
                                                  // ),
                                                  SizedBox(
                                                      height: MySize.size10),
                                                  Expanded(
                                                    child: Text(
                                                      provider
                                                              .checkInOutList[
                                                                  index]
                                                              .name ??
                                                          "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          poppinBold.copyWith(
                                                              fontSize: MySize
                                                                  .size12),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            provider.checkInOutList[index]
                                                    .isAbsent!
                                                ? const AbsentLeaveCard(
                                                    text: "Absent",
                                                    backgroundColor: redColor)
                                                : provider.checkInOutList[index]
                                                        .isLeave!
                                                    ? const AbsentLeaveCard(
                                                        text: "Leave",
                                                        backgroundColor:
                                                            lightGrey)
                                                    : Row(
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                MySize.size30,
                                                          ),
                                                          Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Check in',
                                                                  style: poppinBold
                                                                      .copyWith(
                                                                          fontSize:
                                                                              MySize.size18),
                                                                ),
                                                                Text(
                                                                  provider.checkInOutList[index].checkInTime ==
                                                                          null
                                                                      ? ""
                                                                      : provider
                                                                              .checkInOutList[
                                                                                  index]
                                                                              .checkInTime!
                                                                              .isEmpty
                                                                          ? "Not Checked In"
                                                                          : provider
                                                                              .checkInOutList[index]
                                                                              .checkInTime!,
                                                                  style: poppinMedium
                                                                      .copyWith(
                                                                    fontSize: provider.checkInOutList[index].checkInTime ==
                                                                            null
                                                                        ? MySize
                                                                            .size12
                                                                        : provider.checkInOutList[index].checkInTime!.isEmpty
                                                                            ? MySize.size12
                                                                            : MySize.size16,
                                                                    color: provider.checkInOutList[index].checkInTime ==
                                                                            null
                                                                        ? redColor
                                                                        : provider.checkInOutList[index].checkInTime!.isEmpty
                                                                            ? redColor
                                                                            : blackColor,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      AppIcons
                                                                          .location2,
                                                                      height: MySize
                                                                          .size10,
                                                                      width: MySize
                                                                          .size10,
                                                                    ),
                                                                    Text(
                                                                      'Islamabad i-10',
                                                                      style: poppineRegular.copyWith(
                                                                          fontSize: MySize
                                                                              .size8,
                                                                          color:
                                                                              primaryColor),
                                                                    ),
                                                                  ],
                                                                )
                                                              ]),
                                                          VerticalDivider(
                                                            thickness: 1,
                                                            indent:
                                                                MySize.size16,
                                                            endIndent:
                                                                MySize.size34,
                                                            color: const Color(
                                                                0xffE9E9E9),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                MySize.size20,
                                                          ),
                                                          provider
                                                                      .checkInOutList[
                                                                          index]
                                                                      .checkInTime ==
                                                                  null
                                                              ? const SizedBox()
                                                              : provider
                                                                      .checkInOutList[
                                                                          index]
                                                                      .checkInTime!
                                                                      .isEmpty
                                                                  ? Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        MarkAttendanceButton(
                                                                          text:
                                                                              "Absent",
                                                                          btnColor:
                                                                              redColor,
                                                                          onPressed:
                                                                              () {
                                                                            absentLeaveDialog(context,
                                                                                type: "absent",
                                                                                index: index);
                                                                          },
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        MarkAttendanceButton(
                                                                          text:
                                                                              "Leave",
                                                                          btnColor:
                                                                              lightGrey,
                                                                          onPressed:
                                                                              () {
                                                                            absentLeaveDialog(context,
                                                                                type: "leave",
                                                                                index: index);
                                                                          },
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        MarkAttendanceButton(
                                                                          text:
                                                                              "Remote",
                                                                          btnColor:
                                                                              primaryColor.withOpacity(.8),
                                                                          onPressed:
                                                                              () {
                                                                            absentLeaveDialog(context,
                                                                                type: "remote",
                                                                                index: index);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Check Out',
                                                                          style:
                                                                              poppinBold.copyWith(fontSize: MySize.size18),
                                                                        ),
                                                                        Text(
                                                                          provider.checkInOutList[index].checkOutTime == null
                                                                              ? ""
                                                                              : provider.checkInOutList[index].checkOutTime!.isEmpty
                                                                                  ? "Not Checked Out"
                                                                                  : provider.checkInOutList[index].checkOutTime!,
                                                                          style:
                                                                              poppinMedium.copyWith(
                                                                            fontSize: provider.checkInOutList[index].checkOutTime == null
                                                                                ? MySize.size12
                                                                                : provider.checkInOutList[index].checkOutTime!.isEmpty
                                                                                    ? MySize.size12
                                                                                    : MySize.size16,
                                                                            color: provider.checkInOutList[index].checkOutTime == null
                                                                                ? redColor
                                                                                : provider.checkInOutList[index].checkOutTime!.isEmpty
                                                                                    ? redColor
                                                                                    : blackColor,
                                                                          ),
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
                                                                              style: poppineRegular.copyWith(fontSize: MySize.size8, color: primaryColor),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                        ],
                                                      )
                                          ],
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text(''),
                                    ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () async {
              print("object");
              SmartDialog.showLoading();
              await multipleCheckOutAtOnce();
            },
            child: Container(
              width: double.infinity,
              height: 47,
              decoration: ShapeDecoration(
                color: const Color(0xFF055E13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                  child: Text(
                "Multiple Checkout",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        )
      ],
    );
  }

  absentLeaveDialog(BuildContext context,
      {required String type, required int index}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
          title: Text(
            'Confirm',
            style: poppinBold.copyWith(color: primaryColor),
          ),
          content: Column(children: [
            SizedBox(
              height: MySize.size20,
            ),
            Text(
              'Are you sure want to mark $type',
              style: poppineRegular.copyWith(fontSize: MySize.size16),
            ),
            SizedBox(
              height: MySize.size10,
            ),
          ]),
          actions: [
            TextButton(
              onPressed: () async {
                //timelogic about marking absent/leave
                final formattedDate =
                    DateFormat('yyyy-MM-dd').format(DateTime.now());
                print(formattedDate);
                final provider =
                    Provider.of<AttendanceProvider>(context, listen: false);
                if (type == "absent") {
                  try {
                    bool isInternetConnect = await checkInternetConnection();
                    if (isInternetConnect) {
                      var data = await FirebaseFirestore.instance
                          .collection('checkInOut')
                          .get();
                      final allData = data.docs
                          .where((element) =>
                              element["currentUserId"] ==
                                  provider
                                      .checkInOutList[index].currentUserId &&
                              element['date'] == formattedDate)
                          .toList();
                      if (allData.isEmpty) {
                        DateTime currentMY = DateTime.now();
                        final DateFormat formatter = DateFormat.yMMMM();
                        String myformattedMY = formatter.format(currentMY);
                        DateTime currentTime = DateTime.now();
                        int unixTimestamp =
                            currentTime.millisecondsSinceEpoch ~/ 1000;
                        Map<String, dynamic> newData = {
                          'checkInTime': '',
                          'checkOutTime': '',
                          'currentMY': myformattedMY,
                          'currentUserId':
                              provider.checkInOutList[index].currentUserId,
                          'date': formattedDate,
                          'isPresent': false,
                          'isAbsent': true,
                          'isLeave': false,
                          'unixTimestamp': unixTimestamp
                        };
                        await FirebaseFirestore.instance
                            .collection('checkInOut')
                            .doc()
                            .set(newData)
                            .then((value) {
                          Navigator.pop(context);
                          getFlushBar(context, title: 'Successfully');
                        }).catchError((error) {
                          print(
                              '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\nError updating document: $error');
                        });
                      } else {
                        getFlushBar(context, title: "Already Data Exists");
                      }
                    } else {
                      showNoInternetDialog(context);
                    }
                  } catch (e) {
                    print(e);
                  }
                } else if (type == "leave") {
                  try {
                    bool isInternetConnect = await checkInternetConnection();
                    if (isInternetConnect) {
                      var data = await FirebaseFirestore.instance
                          .collection('checkInOut')
                          .get();
                      final allData = data.docs
                          .where((element) =>
                              element["currentUserId"] ==
                                  provider
                                      .checkInOutList[index].currentUserId &&
                              element['date'] == formattedDate)
                          .toList();
                      if (allData.isEmpty) {
                        DateTime currentMY = DateTime.now();
                        final DateFormat formatter = DateFormat.yMMMM();
                        String myformattedMY = formatter.format(currentMY);
                        DateTime currentTime = DateTime.now();
                        int unixTimestamp =
                            currentTime.millisecondsSinceEpoch ~/ 1000;
                        Map<String, dynamic> newData = {
                          'checkInTime': '',
                          'checkOutTime': '',
                          'currentMY': myformattedMY,
                          'currentUserId':
                              provider.checkInOutList[index].currentUserId,
                          'date': formattedDate,
                          'isPresent': false,
                          'isAbsent': false,
                          'isLeave': true,
                          'unixTimestamp': unixTimestamp
                        };
                        await FirebaseFirestore.instance
                            .collection('checkInOut')
                            .doc()
                            .set(newData)
                            .then((value) {
                          Navigator.pop(context);
                          getFlushBar(context, title: 'Successfully');
                        }).catchError((error) {
                          print('Error updating document: $error');
                        });
                      } else {
                        getFlushBar(context, title: "Already Data Exists");
                      }
                    } else {
                      showNoInternetDialog(context);
                    }
                  } catch (e) {
                    print(e);
                  }
                } else {
                  try {
                    bool isInternetConnect = await checkInternetConnection();
                    if (isInternetConnect) {
                      var data = await FirebaseFirestore.instance
                          .collection('checkInOut')
                          .get();
                      final allData = data.docs
                          .where((element) =>
                              element["currentUserId"] ==
                                  provider
                                      .checkInOutList[index].currentUserId &&
                              element['date'] == formattedDate)
                          .toList();
                      if (allData.isEmpty) {
                        DateTime currentMY = DateTime.now();
                        final DateFormat formatter = DateFormat.yMMMM();
                        String myformattedMY = formatter.format(currentMY);
                        DateTime currentTime = DateTime.now();
                        int unixTimestamp =
                            currentTime.millisecondsSinceEpoch ~/ 1000;
                        Map<String, dynamic> newData = {
                          'checkInTime': '09:00',
                          'checkOutTime': '17:00',
                          'currentMY': myformattedMY,
                          'currentUserId':
                              provider.checkInOutList[index].currentUserId,
                          'date': formattedDate,
                          'isPresent': true,
                          'isAbsent': false,
                          'isLeave': false,
                          'unixTimestamp': unixTimestamp
                        };
                        await FirebaseFirestore.instance
                            .collection('checkInOut')
                            .doc()
                            .set(newData)
                            .then((value) {
                          Navigator.pop(context);
                          getFlushBar(context, title: 'Successfully');
                        }).catchError((error) {
                          print('Error updating document: $error');
                        });
                      } else {
                        getFlushBar(context,
                            title: "Record Already Data Exists");
                      }
                    } else {
                      showNoInternetDialog(context);
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ]),
    );
  }

  multipleCheckOutAtOnce() async {
    final provider = Provider.of<AttendanceProvider>(context, listen: false);
    final time = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var data = await FirebaseFirestore.instance.collection('checkInOut').get();

    for (var i = 0; i < provider.checkInOutList.length; i++) {
      print("object$i");
      final allData = data.docs
          .where((element) =>
              element["currentUserId"] ==
                  provider.checkInOutList[i].currentUserId &&
              element['date'] == time &&
              element.get('checkInTime').toString().isNotEmpty)
          .toList();
      for (var e in allData) {
        if (e.get('checkInTime') != null) {
          if (e.get('checkOutTime').isEmpty) {
            print(e.data());
            Map<String, dynamic> mp = e.data();
            await markCheckOutAll(mp);
            // break;
          }
        }
      }
      // if (i == 2) {
      //   break;
      // }
    }
    SmartDialog.dismiss();
  }

  markCheckOutAll(Map<String, dynamic> mp) async {
    try {
      bool isInternetConnect = await checkInternetConnection();
      if (isInternetConnect) {
        var data =
            await FirebaseFirestore.instance.collection('checkInOut').get();
        final allData = data.docs.where((element) =>
            element["currentUserId"] == mp['currentUserId'] &&
            element['date'] == mp['date'] &&
            element['checkInTime'] == mp['checkInTime'] &&
            element['unixTimestamp'] == mp['unixTimestamp'] &&
            element['isLeave'] == mp['isLeave'] &&
            element['currentMY'] == mp['currentMY'] &&
            element['isPresent'] == mp['isPresent'] &&
            element['isAbsent'] == mp['isAbsent'] &&
            element['checkOutTime'] == mp['checkOutTime']);
        for (var element in allData) {
          print("function");
          print(element.id);
          await FirebaseFirestore.instance
              .collection('checkInOut')
              .doc(element.id)
              .update({'checkOutTime': '17:00'});
        }
      } else {
        showNoInternetDialog(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
