import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/routes/routes_const.dart';
import 'package:elabd_ems_admin/view/manage_task_view/task_detail.dart';
import 'package:intl/intl.dart';
import 'components/task_card.dart';

class ManageTaskView extends StatefulWidget {
  final bool isLeadingIcon;
  const ManageTaskView({super.key, this.isLeadingIcon = false});

  @override
  State<ManageTaskView> createState() => _ManageTaskViewState();
}

class _ManageTaskViewState extends State<ManageTaskView> {
  final taskController = TextEditingController();

  Future selectTaskDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null) {
      taskController.text = '${picked.day}-${picked.month}-${picked.year}';
    }
  }

  final ref = FirebaseFirestore.instance.collection('tasks').snapshots();
  final collectionReference = FirebaseFirestore.instance.collection('tasks');
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    // receive argument like this for named routes
    // final bool receivedArgument =
    //     ModalRoute.of(context)!.settings.arguments as bool;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Manage Task',
        isLeading: widget.isLeadingIcon,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: Column(children: [
          SizedBox(
            height: MySize.size20,
          ),
          // Container(
          //   height: MySize.size56,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //       color: whiteColor,
          //       borderRadius: BorderRadius.circular(MySize.size10),
          //       boxShadow: [
          //         BoxShadow(
          //             blurRadius: 6,
          //             spreadRadius: 0,
          //             offset: Offset(1, 1),
          //             color: blackColor.withOpacity(0.10))
          //       ]),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: MySize.size12, vertical: MySize.size18),
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             '19 July, 2023',
          //             style: poppinMedium.copyWith(fontSize: MySize.size12),
          //           ),
          //           Image.asset(AppIcons.calander)
          //         ]),
          //   ),
          // ),

          TextFieldWidget(
              controller: taskController,
              readOnly: true,
              hintText: '19 July, 2023',
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
              )),

          SizedBox(
            height: MySize.size20,
          ),
          // Align(
          //     alignment: Alignment.centerRight,
          //     child: SizedBox(
          //       height: MySize.size30,
          //       width: MySize.size90,
          //       child: ButtonWidget(
          //         borderRadius: 0,
          //         textColor: whiteColor,
          //         fontSize: MySize.size10,
          //         title: 'Add New',
          //         ontap: () {
          //           Navigator.pushNamed(context, addTask);
          //         },
          //       ),
          //     )),

          SizedBox(
            height: MySize.size20,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: ref,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Something went Wrong',
                          style: poppinMedium,
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No Task Found'),
                      );
                    } else if (snapshot.data?.docs.isEmpty == true) {
                      return const Center(child: Text('No Task Found'));
                    } else {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final data = snapshot.data.docs[index];
                            final taskData = data.data() as Map<String,
                                dynamic>; // Convert QueryDocumentSnapshot to Map

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
                                child: TaskCard(
                                  title: data['taskTitle'],
                                  status: data['taskStatus'],
                                ));
                            // child: Text(data['taskTitle']));
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: MySize.size15,
                              ),
                          itemCount: snapshot.data.docs.length);
                    }
                  }),
            ),
          )
        ]),
      ),
      persistentFooterButtons: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, addTask),
          child: Container(
            margin: const EdgeInsets.all(5),
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
              "Add New",
              style: TextStyle(color: Colors.white),
            )),
          ),
        )
      ],
    );
  }
}
