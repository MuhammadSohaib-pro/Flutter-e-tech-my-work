import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/manage_task_view/task_detail.dart';

// ignore: must_be_immutable
class RecentProjectListWidget extends StatelessWidget {
  const RecentProjectListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    int currentUnixTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int startOfDay = currentUnixTimestamp - (currentUnixTimestamp % 86400);
    int endOfDay = startOfDay + 86399;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('unixTimestamp', isGreaterThanOrEqualTo: startOfDay)
            .where('unixTimestamp', isLessThanOrEqualTo: endOfDay)
            .snapshots(),
        // FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('No Task Found for Today'));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error ${snapshot.hasError}'));
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No Task Found for Today',
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final List<QueryDocumentSnapshot> taskDocs = snapshot.data!.docs;
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size12,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: taskDocs.length,
              itemBuilder: (context, index) {
                final taskData = taskDocs[index].data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskDetail(
                                  taskData: taskData,
                                  // taskId: data['taskId'],
                                  // taskTitle: data['taskTitle'],
                                  // taskDetail: data['taskDetail'],
                                  // taskPirority: data['taskPirority'],
                                  // taskStatus: data['taskStatus'],
                                  // assignedUserId:
                                  //     data['assignedUserId'],
                                  // endDate: data['endDate'],
                                  // startDate: data['startDate'],
                                )));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(MySize.size4),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(2, 2),
                                color: blackColor.withOpacity(0.10))
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MySize.size10, vertical: MySize.size15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                  child: Image.asset(
                                    AppIcons.website,
                                    height: MySize.size20,
                                    width: MySize.size20,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: MySize.size14,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      taskData['taskTitle'],
                                      // recentProjects[index].personName,
                                      style: poppinSemiBold.copyWith(
                                          fontSize: MySize.size15),
                                    ),
                                    SizedBox(
                                      height: MySize.size6,
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Status: ',
                                            style: poppineRegular.copyWith(
                                                color: primaryColor,
                                                fontSize: MySize.size10),
                                          ),
                                          SizedBox(
                                            width: MySize.size10,
                                          ),
                                          Text(
                                            taskData['taskStatus'],
                                            style: poppinBold.copyWith(
                                                fontSize: MySize.size10,
                                                color: primaryColor),
                                          ),
                                          SizedBox(
                                            width: MySize.size8,
                                          ),
                                          Image.asset(
                                            AppIcons.completedicon,
                                            height: MySize.size10,
                                            width: MySize.size10,
                                          )
                                        ],
                                      ),
                                    )

                                    // Text(
                                    //   recentProjects[index].personQualification,
                                    //   style: poppineRegular.copyWith(
                                    //       color: primaryColor,
                                    //       fontSize: MySize.size12),
                                    // ),
                                  ],
                                ),
                                const Spacer(),
                                Image.asset(
                                  AppIcons.arrowforward,
                                  height: MySize.size18,
                                  width: MySize.size10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MySize.size10,
                            ),
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       Text(
                            //         'Status: ',
                            //         style: poppineRegular.copyWith(
                            //             color: primaryColor,
                            //             fontSize: MySize.size10),
                            //       ),
                            //       SizedBox(
                            //         width: MySize.size10,
                            //       ),
                            //       Text(
                            //         recentProjects[index].perjectStatus,
                            //         style: poppinBold.copyWith(
                            //             fontSize: MySize.size10,
                            //             color: primaryColor),
                            //       ),
                            //       SizedBox(
                            //         width: MySize.size4,
                            //       ),
                            //       Image.asset(
                            //         AppIcons.completedicon,
                            //         height: MySize.size10,
                            //         width: MySize.size10,
                            //       )
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      )),
                );
              },
            );
          }
        });
  }
}
