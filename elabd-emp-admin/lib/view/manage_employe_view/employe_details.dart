import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/add_new_employe.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/employe_salary.dart';
import 'package:elabd_ems_admin/view/manage_task_view/components/button_comp.dart';
import 'employe_attendance.dart';
import 'employe_task.dart';

class EmployeDetails extends StatefulWidget {
  final String? receiveId;
  final String? receiveName;
  final Map<String, dynamic>? employeeData;
  // final String? name;
  // final String? email;
  // final String? contact;
  // final String? address;
  // final String? image;
  // final String? joinDate;
  // final String? team;
  // final String? type;
  // final String? id;

  const EmployeDetails({
    super.key,
    this.receiveName,
    this.receiveId,
    this.employeeData,
    // this.name,
    // this.email,
    // this.contact,
    // this.address,
    // this.image,
    // this.joinDate,
    // this.team,
    // this.type,
    // this.id,
  });

  @override
  State<EmployeDetails> createState() => _EmployeDetailsState();
}

class _EmployeDetailsState extends State<EmployeDetails>
    with TickerProviderStateMixin {
  // List<Widget> screens = [
  //   EmployeAttendance(),
  //   const EmployTask(),
  //   const EmployeSalary(),
  // ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    tabController.addListener(() {
      activeIndex = tabController.index;
      setState(() {});
      // screens.addAll([
      //   EmployeAttendance(
      //       receiveId: widget.receiveId, receiveName: widget.receiveName),
      //   const EmployTask(),
      //   const EmployeSalary(),
      // ]);
    });
  }

  late TabController tabController;
  int activeIndex = 0;
  bool isDeleted = false;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    List<Widget> screens = [
      EmployeAttendance(
        currentUserId: widget.employeeData!['id'],
        receiveId: widget.receiveId,
        receiveName: widget.receiveName,
      ),
      EmployTask(currentUserId: widget.employeeData!['id']),
      EmployeSalary(employeData: widget.employeeData),
    ];
    return Scaffold(
      appBar: const AppBarWidget(title: 'Employe Details'),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            key: UniqueKey(),
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
                SliverToBoxAdapter(
                    child: SizedBox(
                        height: MySize.screenHeight * 0.5,
                        width: MySize.screenWidth,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            employeeCard(context),
                            Positioned(
                              top: MySize.screenHeight * 0.04,
                              child: CircleAvatar(
                                radius: MySize.size40,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    const AssetImage(AppIcons.profileCircle),
                                child: CircleAvatar(
                                  radius: MySize.size35,
                                  backgroundImage: NetworkImage(
                                      widget.employeeData!['image']),
                                ),
                              ),
                            ),
                          ],
                        ))),

                /// Tab Bar View
                SliverPersistentHeader(
                  delegate: MyDelegate(TabBar(
                    onTap: (index) {
                      activeIndex = index;
                      setState(() {});
                    },
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    labelColor: blackColor,
                    labelStyle:
                        poppineRegular.copyWith(fontSize: MySize.size12),
                    unselectedLabelStyle:
                        poppineRegular.copyWith(fontSize: MySize.size12),
                    unselectedLabelColor: lightGrey,
                    tabs: [
                      Tab(
                          child: Container(
                        height: MySize.size40,
                        width: MySize.size100,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                            color: tabController.index == 0
                                ? primaryColor
                                : whiteColor,
                            borderRadius: BorderRadius.circular(MySize.size10)),
                        child: Center(
                          child: Text(
                            'Attendance',
                            style: poppineRegular.copyWith(
                              color: tabController.index == 0
                                  ? whiteColor
                                  : blackColor,
                            ),
                          ),
                        ),
                      )),
                      Tab(
                          child: Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: MySize.size40,
                        width: MySize.size100,
                        decoration: BoxDecoration(
                            color: tabController.index == 1
                                ? primaryColor
                                : whiteColor,
                            borderRadius: BorderRadius.circular(MySize.size10)),
                        child: Center(
                          child: Text(
                            'Task',
                            style: poppineRegular.copyWith(
                              color: tabController.index == 1
                                  ? whiteColor
                                  : blackColor,
                            ),
                          ),
                        ),
                      )),
                      Tab(
                          child: Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: MySize.size40,
                        width: MySize.size100,
                        decoration: BoxDecoration(
                            color: tabController.index == 2
                                ? primaryColor
                                : whiteColor,
                            borderRadius: BorderRadius.circular(MySize.size10)),
                        child: Center(
                          child: Text(
                            'Salary',
                            style: poppineRegular.copyWith(
                              color: tabController.index == 2
                                  ? whiteColor
                                  : blackColor,
                            ),
                          ),
                        ),
                      )),
                    ],
                  )),
                  floating: true,
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(controller: tabController, children: screens),
          ),
        ),
      ),
    );
  }

  Widget employeeCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySize.size16),
      child: Column(
        children: [
          SizedBox(
            height: MySize.screenHeight * 0.1,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(MySize.size12),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(2, 2),
                      color: blackColor.withOpacity(0.10))
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size20),
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  widget.employeeData!['name'],
                  // 'name',
                  style: poppinBold.copyWith(fontSize: MySize.size16),
                ),
                Text(
                  widget.employeeData!['email'],
                  style: poppineRegular.copyWith(
                      color: primaryColor, fontSize: MySize.size10),
                ),
                SizedBox(
                  height: MySize.size30,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: infoWidget(
                        title: 'Full Name: ',
                        name: widget.employeeData!['name'],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: infoWidget(
                        title: 'Type: ',
                        name: widget.employeeData!['type'],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: infoWidget(
                        title: 'Contact: ',
                        name: widget.employeeData!['contact'],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: infoWidget(
                        title: 'Salary: ',
                        name: widget.employeeData!['salary'],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                infoWidget(
                  title: 'Address: ',
                  name: widget.employeeData!['address'],
                ),
                SizedBox(
                  height: MySize.screenHeight * 0.05,
                ),
                (widget.employeeData!['status'] == 'Deleted')
                    ? Text(
                        'Employee has been left he company',
                        style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonComp(
                            title: 'Edit',
                            onTap: () {
                              // Navigator.pushNamed(context, addnewEmploye,arguments: widget.employeeData);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddNewEmploye(
                                            employeeDetails:
                                                widget.employeeData,
                                          )));
                            },
                            bordeRadius: MySize.size5,
                          ),
                          SizedBox(
                            width: MySize.size20,
                          ),
                          ButtonComp(
                            title: 'Delete',
                            onTap: () {
                              deleteEmployDialog();
                            },
                            backColor: redColor,
                            bordeRadius: MySize.size5,
                          ),
                        ],
                      ),
                SizedBox(
                  height: MySize.size20,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteEmployDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size6)),
            child: Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size6)),
                  color: whiteColor),
              child: Padding(
                padding: EdgeInsets.all(MySize.size16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          'Delete?',
                          style:
                              poppinSemiBold.copyWith(fontSize: MySize.size24),
                        ),
                      ),
                      SizedBox(
                        height: MySize.size12,
                      ),
                      Text(
                        'Do you want to Deactivate the User',
                        textAlign: TextAlign.center,
                        style: poppineRegular.copyWith(
                          fontSize: MySize.size17,
                        ),
                      ),
                      SizedBox(
                        height: MySize.screenHeight * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () async {
                                try {
                                  SmartDialog.showLoading();
                                  FirebaseFirestore.instance
                                      .collection('employees')
                                      .doc(widget.employeeData!['id'])
                                      .update({'status': 'Deleted'}).then(
                                          (value) async {
                                    String uidToDelete = widget
                                        .employeeData!['id']; // UID to delete

// Query for documents that contain the UID in their "uids" array
                                    QuerySnapshot querySnapshot =
                                        await FirebaseFirestore.instance
                                            .collection('teams')
                                            .where('uids',
                                                arrayContains: uidToDelete)
                                            .get();

                                    if (querySnapshot.docs.isNotEmpty) {
                                      // Get the first document that matches
                                      QueryDocumentSnapshot documentSnapshot =
                                          querySnapshot.docs.first;

                                      // Get the current "uids" array
                                      List<dynamic> uidsArray =
                                          documentSnapshot.get('uids');

                                      // Remove the specific UID
                                      uidsArray.remove(uidToDelete);

                                      // Update the document with the modified "uids" array
                                      await documentSnapshot.reference
                                          .update({'uids': uidsArray});

                                      print(
                                          'UID $uidToDelete removed from the document successfully.');
                                    } else {
                                      print(
                                          'No document contains UID $uidToDelete.');
                                    }

                                    SmartDialog.dismiss();
                                    setState(() {});
                                    isDeleted = true;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavigationBarView(
                                                  index: 2,
                                                )));
                                  });
                                } catch (e) {
                                  SmartDialog.dismiss();
                                  getFlushBar(context,
                                      title: 'Error ${e.toString()}');
                                }
                              },
                              child: const Text('Delete')),
                        ],
                      )
                    ]),
              ),
            ),
          );
        });
  }

  Widget infoWidget({required String title, required String name}) {
    return Row(
      children: [
        Text(
          title,
          style: poppineRegular.copyWith(
              fontSize: MySize.size10, color: lightGrey),
        ),
        Expanded(
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: poppineRegular.copyWith(fontSize: MySize.size10),
          ),
        ),
      ],
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
