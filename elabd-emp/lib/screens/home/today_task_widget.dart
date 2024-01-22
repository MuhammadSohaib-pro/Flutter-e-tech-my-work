import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodayTaskWidget extends StatelessWidget {
  final String id;
  const TodayTaskWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    int currentUnixTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int startOfDay = currentUnixTimestamp - (currentUnixTimestamp % 86400);
    int endOfDay = startOfDay + 86399;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('assignedUserId', isEqualTo: id)
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
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: taskDocs.length,
              itemBuilder: (context, index) {
                final taskData = taskDocs[index].data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => TaskDetail(
                    //               taskData: taskData,
                    //                                               )));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(2, 2),
                                color: black.withOpacity(0.10))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/websiteicon.png',
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      taskData['taskTitle'],
                                      // recentProjects[index].personName,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text(
                                            'Status: ',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 10),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            taskData['taskStatus'],
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: primaryColor),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Image.asset(
                                            'assets/images/circle_tick.png',
                                            height: 10,
                                            width: 10,
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
                                  'assets/images/forward.png',
                                  height: 18,
                                  width: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
