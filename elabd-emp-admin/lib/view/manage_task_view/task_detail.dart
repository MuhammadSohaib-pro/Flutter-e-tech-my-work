// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:elabd_ems_admin/view/manage_task_view/add_task.dart';
import 'package:elabd_ems_admin/view/manage_task_view/components/button_comp.dart';
import 'package:elabd_ems_admin/view/manage_task_view/components/task_detail_description.dart';

class TaskDetail extends StatefulWidget {
  final Map<String, dynamic>? taskData;
  // final QueryDocumentSnapshot? taskData;
  // final String? assignedUserId;
  // final String? startDate;
  // final String? endDate;
  // final String? taskDetail;
  // final String? taskId;
  // final String? taskPirority;
  // final String? taskStatus;
  // final String? taskTitle;
  const TaskDetail({
    Key? key,
    this.taskData,
    // this.assignedUserId,
    // this.startDate,
    // this.endDate,
    // this.taskDetail,
    // this.taskId,
    // this.taskPirority,
    // this.taskStatus,
    // this.taskTitle,
  }) : super(key: key);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      appBar: const AppBarWidget(title: 'Task Details'),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: Column(
          children: [
            SizedBox(
              height: MySize.size20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Assigned Date ',
                    style: poppinMedium.copyWith(fontSize: MySize.size8),
                    children: [
                      TextSpan(
                          // text: widget.taskStatus,
                          text: widget.taskData!['startDate'],
                          style: poppineRegular.copyWith(
                              fontSize: MySize.size8, color: primaryColor)),
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(widget.taskData!['taskId'])
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

                        return RichText(
                          text: TextSpan(
                            text: 'Current Status: ',
                            style:
                                poppinMedium.copyWith(fontSize: MySize.size8),
                            children: [
                              TextSpan(
                                  // text: widget.taskStatus,
                                  text: data['taskStatus'],
                                  style: poppineRegular.copyWith(
                                      fontSize: MySize.size8,
                                      color: primaryColor)),
                            ],
                          ),
                        );
                      }
                    }))
              
              ],
            ),
            SizedBox(
              height: MySize.size20,
            ),
            TaskDetailDescription(
              title: widget.taskData!['taskTitle'],
              desc: widget.taskData!['taskDetail'],
              status: widget.taskData!['taskStatus'],
              taskId: widget.taskData!['taskId'],
              assignedUserId: widget.taskData!['assignedUserId'],
            ),
            SizedBox(
              height: MySize.size20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonComp(
                    title: 'Edit',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTask(
                                    taskData: widget.taskData,
                                  )));
                    }),
                SizedBox(
                  width: MySize.size16,
                ),
                ButtonComp(
                  title: 'Delete',
                  onTap: () async {
                    showDeleteTaskDialog(context);
                  },
                  backColor: redColor,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void showDeleteTaskDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size8),
              ),
              child: Container(
                decoration: ShapeDecoration(
                    color: whiteColor,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(MySize.size8))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          'Confirm',
                          style: poppinBold.copyWith(
                              fontSize: MySize.size18, color: primaryColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(MySize.size8),
                        child: Text(
                          "Do you want to remove the Task",
                          textAlign: TextAlign.center,
                          style: poppinBold.copyWith(
                              fontSize: MySize.size16, color: blackColor),
                        ),
                      ),
                      SizedBox(height: MySize.size30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(widget.taskData!['taskId'])
                                    .delete()
                                    .then((value) {
                                  getFlushBar(context,
                                      title: 'Deleted Successfully');

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationBarView(
                                          index: 1,
                                        ),
                                      ));
                                }).onError((error, stackTrace) {
                                  getFlushBar(context,
                                      title: 'Error ${error.toString()}');
                                });
                              },
                              child: const Text('Yes')),

                          //   ButtonComp(
                          //       textColor: Colors.white,
                          //       title: "No",
                          //       backColor: primaryColor,
                          //       onTap: () {
                          //         Navigator.pop(context);
                          //       }),
                          //   ButtonComp(
                          //       textColor: Colors.white,
                          //       title: "Yes",
                          //       backColor: redColor,
                          //       onTap: () async {
                          //         await FirebaseFirestore.instance
                          //             .collection('tasks')
                          //             .doc(widget.taskData!['taskId'])
                          //             .delete()
                          //             .then((value) {
                          //           getFlushBar(context,
                          //               title: 'Deleted Successfully');
                          //           Navigator.pushReplacement(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) =>
                          //                       const ManageTaskView(
                          //                         isLeadingIcon: false,
                          //                       )));
                          //         }).onError((error, stackTrace) {
                          //           getFlushBar(context,
                          //               title: 'Error ${error.toString()}');
                          //         });
                          //       })
                          //
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
