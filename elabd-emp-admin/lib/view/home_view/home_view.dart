import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/home_view/components/home_appbar.dart';
import 'package:elabd_ems_admin/view/home_view/components/home_cart.dart';
import 'package:elabd_ems_admin/view/notifications/leave_request.dart';
import 'components/recent_project_list_widget.dart';

class HomeView extends StatefulWidget {
  
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int pendingRequestCount = 0;
  Future<void> fetchPendingRequestCount() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('leaveRequests')
          .where('status', isEqualTo: 'Pending')
          .get();

      setState(() {
        pendingRequestCount = querySnapshot.size;
      });
    } catch (error) {
      debugPrint('Error fetching pending request count: $error');
    }
  }

  @override
  void initState() {
    fetchPendingRequestCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(body: SafeArea(child: Column(
          children: [
            const HomeAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MySize.screenHeight * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MySize.size16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LeaveRequest()));
                            },
                            child: Container(
                              height: MySize.scaleFactorHeight * 85,
                              width: MySize.screenWidth,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size5),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        offset: const Offset(2, 2),
                                        color: blackColor.withOpacity(0.10))
                                  ]),
                              child: Row(children: [
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                      child: Text(
                                    'Leave Requests',
                                    style: poppinMedium.copyWith(
                                        color: primaryColor,
                                        fontSize: MySize.size14),
                                  )),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.33),
                                        borderRadius: BorderRadius.circular(
                                            MySize.size5)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          pendingRequestCount.toString(),
                                          // '4',
                                          style: poppinMedium.copyWith(
                                              color: primaryColor,
                                              fontSize: MySize.size20),
                                        ),
                                        Text(
                                          'Pending',
                                          style: poppinMedium.copyWith(
                                              color: primaryColor,
                                              fontSize: MySize.size12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: MySize.size10,
                          ),
                          const HomeCart(),
                          SizedBox(
                            height: MySize.size20,
                          ),
                          const Text(
                            'Recents Projects',
                            style: poppinSemiBold,
                          ),
                          SizedBox(
                            height: MySize.size14,
                          ),
                          const RecentProjectListWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
    ),
    
    ));
  }

  // Widget exitDialog(BuildContext context) {
  //   return Dialog(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(MySize.size4)),
  //       child: Column(mainAxisSize: MainAxisSize.min, children: [
  //         SizedBox(
  //           height: MySize.size10,
  //         ),
  //         Text(
  //           'Confirm',
  //           style: poppinBold.copyWith(color: primaryColor),
  //         ),
  //         const Divider(),
  //         SizedBox(
  //           height: MySize.size10,
  //         ),
  //         Text(
  //           'Are you Sure you want to exit',
  //           style: poppineRegular.copyWith(fontSize: MySize.size16),
  //         ),
  //         SizedBox(
  //           height: MySize.size14,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             TextButton(
  //                 child: const Text('YES'),
  //                 onPressed: () {
  //                   SystemNavigator.pop();
  //                 }),
  //             TextButton(
  //                 child: const Text('No'),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 }),
  //           ],
  //         )
  //       ]));
  // }
}
