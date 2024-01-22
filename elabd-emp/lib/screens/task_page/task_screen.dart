import 'package:elabd_tms_app/components/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import '../../components/custom_text.dart';
import '../../constants/colors.dart';
import '../home/home_screen_provider.dart';
import '../task_details/task_details_provider.dart';
import '../task_details/task_details_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        backgroundColor: Colors.white,
        title: "Task Page",
        textColor: black,
      ),
      body: SafeArea(
          child: Consumer<HomeScreenProvider>(
        builder: (context, provider, _) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 18.h),
            child: Column(
              children: [
                WeeklyDatePicker(
                  selectedDay: _selectedDay,
                  changeDay: (value) => setState(() {
                    _selectedDay = value;
                  }),
                  enableWeeknumberText: false,
                  weeknumberColor: const Color(0xFF57AF87),
                  weeknumberTextColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  weekdayTextColor: const Color(0xFF8A8A8A),
                  digitsColor: const Color(0xff7B6F72),
                  selectedBackgroundColor: const Color(0xFF57AF87),
                  weekdays: const ["Mo", "Tu", "We", "Th", "Fr"],
                  daysInWeek: 5,
                ),
                const SizedBox(
                  height: 30,
                ),
                taskWidget(_selectedDay),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

Widget taskWidget(DateTime selectedDay) {
  return Consumer<TaskDetailsProvider>(
    builder: (context, provider, _) =>
        StreamBuilder<List<Map<String, dynamic>>>(
            stream: provider.taskData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              if (snapshot.hasData) {
                {
                  final tasksData = snapshot.data!;
                  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
                  final filteredTasks = tasksData.where((record) {
                    final DateFormat formatter = DateFormat("yyyy-MM-dd");
                    var formatedDate = formatter.format(selectedDay);
                    DateTime selectedDate = DateTime.parse(formatedDate);
                    // Fetch start and end dates
                    DateTime recordStartDate =
                        DateTime.parse(record['startDate']);
                    DateTime recordEndDate = DateTime.parse(record['endDate']);
                    return record['currentUserId'] == currentUserUid &&
                            recordStartDate.isAfter(selectedDate) &&
                            recordEndDate.isBefore(selectedDate) ||
                        recordStartDate.isAtSameMomentAs(selectedDate) ||
                        recordEndDate.isAtSameMomentAs(selectedDate);
                  }).toList();
                  if (filteredTasks.isEmpty) {
                    return const Text('No data');
                  }
                  return ListView.separated(
                    itemCount: filteredTasks.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final taskName = task['taskTitle'];
                      final status = task['taskStatus'];
                      print("Single Task Key ${task.keys}");
                      return Container(
                        padding: const EdgeInsets.all(20),
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
                        child: Row(
                          children: [
                            Container(
                              width: 35.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xffC8E5B2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const SizedBox(
                                width: 20,
                                height: 20,
                                child: Image(
                                  color: primaryColor,
                                  image:
                                      AssetImage("assets/images/uxappicon.png"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: taskName.toString(),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: black,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: "Status : ",
                                      fontSize: 10.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    CustomText(
                                      text: status.toString(),
                                      fontSize: 10.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image(
                                        color: primaryColor,
                                        image: AssetImage(
                                            "assets/images/circle_tick.png"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      // print(task);
                                      //Navigate to Detail Page
                                      Get.to(TaskDetailScreen(
                                        task: task,
                                      ));
                                    },
                                    child: const Icon(Icons.arrow_forward_ios))
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            }),
  );
}
