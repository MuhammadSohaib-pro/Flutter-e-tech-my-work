import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/screens/home/home_screen_provider.dart';
import 'package:elabd_tms_app/screens/home/leave_request.dart';
import 'package:elabd_tms_app/screens/task_details/task_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../constants/colors.dart';
import '../../models/attendence_model.dart';
import '../../models/task_model.dart';

import '../../services/notification_services.dart';
import 'home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AttendenceModel> attendenceList =
      List<AttendenceModel>.empty(growable: true);
  List<TaskModel> taskList = List<TaskModel>.empty(growable: true);
  bool isButtonVisible = true;

  CollectionReference? collection;
  QuerySnapshot? querySnapshot;
  String? formattedDate;

  bool isCheckedIn = true;
  bool isCheckOut = true;

  late String iinnn;

  Position? userCurrentPosition;
  LocationPermission? _locationPermission;
  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        
    // userCurrentPosition = cPosition;
    // LatLng latLngPosition =
    // LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    // await Provider.of<HomeScreenProvider>(context, listen: false)
    //     .findRangBetweenUserAndCompnay(cPosition);
  }

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    } else if (_locationPermission == LocationPermission.always ||
        _locationPermission == LocationPermission.whileInUse) {
      await locateUserPosition();
    }
  }

  callCheckInFunction() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser?.uid ?? '';
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    collection = FirebaseFirestore.instance.collection('checkInOut');
    querySnapshot = await collection
        ?.where('date', isEqualTo: formattedDate)
        .where('currentUserId', isEqualTo: userId)
        .get();
    isCheckedIn = querySnapshot!.docs.isNotEmpty;
    setState(() {});
  }

  Future<void> getTaskStatusCounts() async {
    final tasksCollection = FirebaseFirestore.instance.collection('tasks');

    final completedSnapshot = await tasksCollection
        .where('assignedUserId', isEqualTo: userId)
        .where('taskStatus', isEqualTo: 'Completed')
        .get();

    final finishedSnapshot = await tasksCollection
        .where('assignedUserId', isEqualTo: userId)
        .where('taskStatus', isEqualTo: 'Finished')
        .get();
    final assignedSnapshot = await tasksCollection
        .where('assignedUserId', isEqualTo: userId)
        .where('taskStatus', isEqualTo: 'Assigned')
        .get();

    final onHoldSnapshot = await tasksCollection
        .where('assignedUserId', isEqualTo: userId)
        .where('taskStatus', isEqualTo: 'OnHold')
        .get();

    completedCount = completedSnapshot.size.toString();
    finishedCount = finishedSnapshot.size.toString();
    assignedCount = assignedSnapshot.size.toString();
    onHoldCount = onHoldSnapshot.size.toString();
  }

  callCheckOutFunction() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser?.uid ?? '';
    log(userId, name: "isCheckOutisCheckOut");
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    collection = FirebaseFirestore.instance.collection('checkInOut');
    try {
      log("tryyyyyyyyyyyyyyyyyyyyyy");
      log('aaaaasddsasaasdadsas');

      querySnapshot = await collection
          ?.where('date', isEqualTo: formattedDate)
          .where('currentUserId', isEqualTo: userId)
          .get();
      log('aaaaasddsasaasdadsas2');
      print(querySnapshot);

      if (querySnapshot!.docs.isEmpty) {
        log('aaaaasddsasaasdadsas3');

        isCheckOut = false;
        return;
      }
      querySnapshot = await collection
          ?.where('date', isEqualTo: formattedDate)
          .where('checkOutTime', isEqualTo: '')
          .where('currentUserId', isEqualTo: userId)
          .get();
      isCheckOut = querySnapshot!.docs.isEmpty;
      log("$querySnapshot", name: "isCheckOutisCheckOut");
      setState(() {
        // Update your state variables here
      });
    } catch (error) {
      // Handle the error
      log("$error", name: "errorerror");
      print('Failed to perform check-out: $error');
    }
  }

  String todayDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

  List<DocumentSnapshot> employee = [];
  Map<String, dynamic> userData = {};
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    checkIfLocationPermissionAllowed();
    callCheckInFunction();
    callCheckOutFunction();
    log("$callCheckOutFunction", name: "callCheckOutFunction");

    ////
    attendenceList.add(AttendenceModel(key: "10", value: "2"));
    attendenceList.add(AttendenceModel(key: "20", value: "4"));
    attendenceList.add(AttendenceModel(key: "30", value: "6"));
    attendenceList.add(AttendenceModel(key: "30", value: "8"));
    attendenceList.add(AttendenceModel(key: "40", value: "7"));
    attendenceList.add(AttendenceModel(key: "50", value: "8"));
    attendenceList.add(AttendenceModel(key: "60", value: "4"));

    //
    taskList.add(TaskModel(key: "10", value: "2"));
    taskList.add(TaskModel(key: "20", value: "4"));
    taskList.add(TaskModel(key: "30", value: "5"));
    taskList.add(TaskModel(key: "40", value: "6"));
    taskList.add(TaskModel(key: "50", value: "7"));
    taskList.add(TaskModel(key: "60", value: "8"));
    taskList.add(TaskModel(key: "70", value: "9"));

    getEmployee();
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      debugPrint('Device Token is');
      debugPrint(value);
      getTaskStatusCounts();
    });

    currentUser = FirebaseAuth.instance.currentUser;
    fetchUserData();
  }

  User? currentUser;
  String? userName;
  String? userImage;
  String? userId;
  String? completedCount;
  String? finishedCount;
  String? assignedCount;
  String? onHoldCount;
  String? id;
  String? startDate;
  String? endDate;

  Future<void> fetchUserData() async {
    final userDataSnapshot = await FirebaseFirestore.instance
        .collection('employees')
        .doc(currentUser!.uid)
        .get();

    setState(() {
      userData = userDataSnapshot.data() as Map<String, dynamic>;
      id = userData['id'];
      final weekDates = getWeekStartAndEndDates(DateTime.now());
      startDate = weekDates['start_date'];
      endDate = weekDates['end_date'];
    });
  }

  //final userId = getIt<AuthServiceProvider>().user!.uid;

  @override
  Widget build(BuildContext context) {
    // print('Completed Tasks: ${counts['Completed']}');
    // print('Finished Tasks: ${counts['Finished']}');
    // print('Assigned Tasks: ${counts['Assigned']}');
    // print('O Tasks: ${counts['OnHold']}');
    int currentUnixTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int startOfDay = currentUnixTimestamp - (currentUnixTimestamp % 86400);
    int endOfDay = startOfDay + 86399;

    return Scaffold(
      backgroundColor: Colors.white,

      // CustomAppBar(
      //   leading: Column(children: [
      //     Text('h'),
      //     Text('h'),
      //   ],),
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           // // it's may be null
      //           // // no need of this this is when we check from splash screen etc
      //           User? user = FirebaseAuth.instance.currentUser;
      //           print(user);
      //           DocumentSnapshot userData = await FirebaseFirestore.instance
      //               .collection('employees')
      //               .doc(user!.uid)
      //               .get();
      //           UserModel userModel =
      //               UserModel.fromJson(userData.data() as Map<String, dynamic>);
      //           String name = userModel.name ?? '';
      //           String email = userModel.email ?? '';
      //           print(" my name is $name");
      //           print(" the email is $email");
      //
      //           // ignore: use_build_context_synchronously
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => ChatUsersList(
      //                         userData: userModel,
      //                       )));
      //         },
      //         icon: Icon(
      //           Icons.mark_unread_chat_alt,
      //           color: Colors.black,
      //           size: 30.sp,
      //         )),
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.notifications_none_outlined,
      //           color: Colors.black,
      //           size: 30.sp,
      //         )),
      //   ],
      // ),
      // ignore: unnecessary_null_comparison
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            Consumer<HomeScreenProvider>(builder: (context, provider, _) {
              return SingleChildScrollView(
                  child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    // dashboardContainer(),
                    // const SizedBox(height: 20),
                    attendanceContainer(),
                    const SizedBox(height: 20),
                    // attendanceReportContainer(),

                    // taskReportContainer(),
                    // TodayTaskWidget(id: id!),
                    CustomText(
                      text: "Today Tasks",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('tasks')
                            .where('assignedUserId', isEqualTo: id)
                            // .where('startDate', isLessThanOrEqualTo: startDate)
                            // .where('endDate',
                            //     isLessThanOrEqualTo: endDate)
                            .where('unixTimestamp',
                                isGreaterThanOrEqualTo: startOfDay)
                            .where('unixTimestamp',
                                isLessThanOrEqualTo: endOfDay)
                            .snapshots(),
                        // FirebaseFirestore.instance.collection('tasks').snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: Text('No Task Found for Today'));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error ${snapshot.hasError}'));
                          } else if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(
                                'No Task Found for Today',
                              ),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final List<QueryDocumentSnapshot> taskDocs =
                                snapshot.data!.docs;

                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 12,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: taskDocs.length,
                              itemBuilder: (context, index) {
                                final taskData = taskDocs[index].data()
                                    as Map<String, dynamic>;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TaskDetailScreen(
                                                  task: taskData,
                                                )));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      taskData['taskTitle'],
                                                      // recentProjects[index].personName,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                            'Status: ',
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 10),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            taskData[
                                                                'taskStatus'],
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    primaryColor),
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
                        }),

                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     const SizedBox(
                    //       width: 20,
                    //       height: 20,
                    //       child: Image(
                    //         image: AssetImage("assets/images/salaryreport.png"),
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     CustomText(
                    //       text: "Salary Report",
                    //       fontSize: 20.sp,
                    //       fontWeight: FontWeight.w500,
                    //       color: primaryColor,
                    //     ),
                    //     const Spacer(),
                    //     InkWell(
                    //       child: const Icon(Icons.arrow_forward_ios),
                    //       onTap: () {
                    //         print(userData);
                    //         Get.to(SalaryReportScreen(
                    //           employeeData: userData,
                    //         ));
                    //       },
                    //     ),
                    //   ],
                    // ),
                    //
                  ],
                ),
              ));
            }),
          ],
        ),
      ),
    );
  }

  // Future<void> _pickImage(ImageSource source) async {
  //   final pickedImage = await ImagePicker().pickImage(source: source);
  //   if (pickedImage != null) {
  //     final imageFile = File(pickedImage.path);
  //     .setImage(imageFile);
  //   }
  // }

  Widget attendanceContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            CustomText(
              text: "Attendance",
              color: primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            const Spacer(),
            const Icon(
              Icons.location_on_outlined,
              color: primaryColor,
              size: 20,
            ),
            Consumer<HomeScreenProvider>(
              builder: (context, provider, _) => CustomText(
                text: provider.userCurrentAddress.isNotEmpty
                    ? provider.userCurrentAddress
                    : "loading ...",
                color: primaryColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // Consumer<HomeScreenProvider>(
        //   builder: (context, provider, _) {
        //     // FirebaseFirestore.instance.collection('checkInOut').
        //     final checkInDateTime = provider.checkInDateTime;
        //     final checkOutDateTime = provider.checkOutDateTime;
        //
        //     return
        Consumer<HomeScreenProvider>(
          builder: (context, provider, child) => !provider.officeTimming
              ? Container(
                  alignment: Alignment.center,
                  height: 45,
                  child: const Text(
                    'Not an Office Timming',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomText(
                            text: "09:00 AM",
                            color: halfSilverColor,
                            fontSize: 12,
                          ),
                          const SizedBox(height: 5),
                          Consumer<HomeScreenProvider>(
                            builder: (context, provider, _) {
                              if (isCheckedIn == true) {
                                // User has already checked in, show a message
                                return const Text(
                                  'You have checked In',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13),
                                );
                              } else {
                                // User has not checked in, show the button
                                return CustomButton(
                                  textColor: Colors.white,
                                  image: "assets/images/checkIn.png",
                                  width: 125.w,
                                  height: 40.h,
                                  color: primaryColor,
                                  text: 'Check In',
                                  onPressed: () {
                                    if (_locationPermission ==
                                            LocationPermission.denied ||
                                        _locationPermission ==
                                            LocationPermission.deniedForever) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: Container(
                                                  width: 333,
                                                  height: 304,
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 10,
                                                        offset: Offset(2, 2),
                                                        spreadRadius: 0,
                                                      ),
                                                      BoxShadow(
                                                        color:
                                                            Color(0x19000000),
                                                        blurRadius: 10,
                                                        offset: Offset(-2, -2),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                          "assets/images/Group2.png"),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Text(
                                                        'Provide your location!',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 2,
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 70),
                                                        child: Text(
                                                          'In order to proceed further. It is mandatory for us know your location.',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 2,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          width: 93.88,
                                                          height: 35.03,
                                                          decoration:
                                                              const ShapeDecoration(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  width: 0.75,
                                                                  color: Color(
                                                                      0xFFD9D9D9)),
                                                            ),
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFFD9D9D9),
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                height: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )

                                                      // GestureDetector()
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    } else {
                                      if (provider.userWithinRange) {
                                        print("=============");
                                        iinnn = DateFormat.Hm()
                                            .format(DateTime.now());

                                        provider.performCheckIn();
                                        isCheckedIn = true;

                                        setState(() {});
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => Dialog(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Center(
                                                            child: Image.asset(
                                                          'assets/images/Group.png',
                                                          height: 50,
                                                          width: 40,
                                                        )),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const Text(
                                                          'Opps!',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Sorry you are currently not available on your company location.',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Center(
                                                          child: TextButton(
                                                            child: const Text(
                                                                'Cancel'),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      }
                                    }
                                  },
                                );
                              }
                            },
                          )
                          // if (checkInDateTime != null)
                          //   CustomText(
                          //     text:
                          //         'Checkin Time: \n${DateFormat.Hms().format(checkInDateTime)}',
                          //     color: Colors.black,
                          //     fontSize: 16,
                          //   ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "05:00 PM",
                            color: halfSilverColor,
                            fontSize: 12,
                          ),
                          const SizedBox(height: 5),
                          // if (checkInDateTime != null && checkOutDateTime == null)
                          Consumer<HomeScreenProvider>(
                              builder: (context, provider, _) {
                            if (isCheckOut == true) {
                              return const Text(
                                'You have checked Out',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13),
                              );
                            } else if (isCheckedIn) {
                              return CustomButton(
                                image: "assets/images/checkIn.png",
                                width: 125.w,
                                height: 40.h,
                                textColor: Colors.white,
                                color: redColor,
                                text: 'Check Out',
                                onPressed: () {
                                  if (provider.userWithinRange) {
                                    provider.performCheckOut();
                                    isCheckOut = true;
                                    String arrivalTime = '09:00';
                                    String departureTime = '17:00';
                                    String formattedTime =
                                        DateFormat.Hm().format(DateTime.now());

                                    var totalTime = provider.calculateTotalTime(
                                        arrivalTime,
                                        departureTime,
                                        iinnn,
                                        formattedTime);

                                    log("$totalTime", name: "totalTime");

                                    setState(() {});
                                  } else {
                                    print("vlaur is false");
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: Container(
                                                width: 333,
                                                height: 304,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 10,
                                                      offset: Offset(2, 2),
                                                      spreadRadius: 0,
                                                    ),
                                                    BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 10,
                                                      offset: Offset(-2, -2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/Group.png"),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      'Opps!',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 2,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 70),
                                                      child: Text(
                                                        'Sorry you are currently not available on your company location.',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 50,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: 93.88,
                                                        height: 35.03,
                                                        decoration:
                                                            const ShapeDecoration(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                width: 0.75,
                                                                color: Color(
                                                                    0xFFD9D9D9)),
                                                          ),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFD9D9D9),
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                  }
                                },
                              );
                            } else {
                              return CustomButton(
                                image: "assets/images/checkIn.png",
                                width: 125.w,
                                height: 40.h,
                                textColor: Colors.white,
                                color: halfSilverColor,
                                text: 'Check Out',
                                onPressed: () {},
                              );
                            }
                          })

                          // if (checkOutDateTime != null)
                          //   CustomText(
                          //     text:
                          //         'Checkout Time: \n${DateFormat.Hms().format(checkOutDateTime)}',
                          //     color: Colors.black,
                          //     fontSize: 16,
                          //   ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 9, top: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LeaveRequests()));
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.75,
              height: 47,
              decoration: ShapeDecoration(
                color: const Color(0xFF055E13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                  child: Text(
                "Request Leave",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        )
      ]),
    );
  }

  Widget dashboardContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Dashboard",
            color: primaryColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: "COMPLETED TASK",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: skyBlueColor,
                      ),
                      SizedBox(width: 20.w),
                      CustomText(
                        text: completedCount != null
                            ? completedCount.toString()
                            : '0',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: skyBlueColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: "FINISHED TASK",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: halfBlacColor,
                      ),
                      SizedBox(width: 20.w),
                      CustomText(
                        text: finishedCount != null
                            ? finishedCount.toString()
                            : '0',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: halfBlacColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     CustomText(
                  //       text: "REOPENED TASK",
                  //       fontSize: 11.sp,
                  //       fontWeight: FontWeight.w600,
                  //       color: redColor,
                  //     ),
                  //     SizedBox(width: 20.w),
                  //     CustomText(
                  //       text: "0",
                  //       fontSize: 11.sp,
                  //       fontWeight: FontWeight.w600,
                  //       color: redColor,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: "ASSIGNED TASK",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFECC160),
                      ),
                      SizedBox(width: 20.w),
                      CustomText(
                        text: assignedCount != null
                            ? assignedCount.toString()
                            : '0',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: skyBlueColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: "ON HOLD TASK",
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFBEBBBB),
                      ),
                      SizedBox(width: 20.w),
                      CustomText(
                        text:
                            onHoldCount != null ? onHoldCount.toString() : '0',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: halfBlacColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     CustomText(
                  //       text: "ON HOLD TASK",
                  //       fontSize: 11.sp,
                  //       fontWeight: FontWeight.w600,
                  //       color: Color(0xFFA02724),
                  //     ),
                  //     SizedBox(width: 20.w),
                  //     CustomText(
                  //       text: "0",
                  //       fontSize: 11.sp,
                  //       fontWeight: FontWeight.w600,
                  //       color: redColor,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget attendanceReportContainer() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             CustomText(
  //               text: "Statistics",
  //               fontSize: 15.sp,
  //               fontWeight: FontWeight.w600,
  //               color: black,
  //             ),
  //             const Spacer(),
  //             CustomText(
  //               text: "Monthly",
  //               fontSize: 16.sp,
  //               fontWeight: FontWeight.w500,
  //               color: primaryColor,
  //             ),
  //             Icon(
  //               Icons.arrow_drop_down_circle_outlined,
  //               size: 30.sp,
  //               color: primaryColor,
  //             )
  //           ],
  //         ),
  //         SizedBox(
  //           height: 20.h,
  //         ),
  //         Row(
  //           children: [
  //             const SizedBox(
  //               width: 20,
  //               height: 20,
  //               child: Image(
  //                 image: AssetImage("assets/images/clock.png"),
  //               ),
  //             ),
  //             const Spacer(),
  //             CustomText(
  //               text: "Attendence Report",
  //               fontSize: 18.sp,
  //               fontWeight: FontWeight.w500,
  //               color: primaryColor,
  //             ),
  //             const Spacer(),
  //             CustomText(
  //               text: "93%",
  //               fontSize: 15.sp,
  //               fontWeight: FontWeight.w600,
  //               color: black,
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         SizedBox(
  //           height: 150.h,
  //           child: BarChart(
  //             BarChartData(
  //               backgroundColor: Colors.white,
  //               barGroups: _chartGroup(),
  //               borderData: FlBorderData(
  //                 border:
  //                     const Border(bottom: BorderSide(), left: BorderSide()),
  //               ),
  //               gridData: FlGridData(show: false),
  //               titlesData: FlTitlesData(
  //                 bottomTitles: AxisTitles(sideTitles: _bottomTitles),
  //                 leftTitles: AxisTitles(
  //                   sideTitles: SideTitles(
  //                     showTitles: true,
  //                     interval: 1,
  //                     getTitlesWidget: (value, meta) {
  //                       return Text(
  //                         value.toString(),
  //                         style: const TextStyle(fontSize: 10),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 topTitles:
  //                     AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //                 rightTitles:
  //                     AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget taskReportContainer() {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           const SizedBox(
  //             width: 20,
  //             height: 20,
  //             child: Image(
  //               image: AssetImage("assets/images/taskreport.png"),
  //             ),
  //           ),
  //           const Spacer(),
  //           CustomText(
  //             text: "Tasks Report",
  //             fontSize: 18.sp,
  //             fontWeight: FontWeight.w500,
  //             color: primaryColor,
  //           ),
  //           const Spacer(),
  //           CustomText(
  //             text: "93%",
  //             fontSize: 15.sp,
  //             fontWeight: FontWeight.w600,
  //             color: black,
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: 20,
  //       ),
  //       SizedBox(
  //         height: 150,
  //         child: BarChart(
  //           BarChartData(
  //             backgroundColor: Colors.white,
  //             barGroups: taskChartGroup(),
  //             borderData: FlBorderData(
  //               border: const Border(bottom: BorderSide(), left: BorderSide()),
  //             ),
  //             gridData: FlGridData(show: false),
  //             titlesData: FlTitlesData(
  //               bottomTitles: AxisTitles(sideTitles: bottomTilesTask),
  //               leftTitles: AxisTitles(
  //                 sideTitles: SideTitles(
  //                   showTitles: true,
  //                   interval: 1,
  //                   getTitlesWidget: (value, meta) {
  //                     return Text(
  //                       value.toString(),
  //                       style: const TextStyle(fontSize: 10),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               topTitles:
  //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //               rightTitles:
  //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  List<BarChartGroupData> taskChartGroup() {
    List<BarChartGroupData> list =
        List<BarChartGroupData>.empty(growable: true);
    for (int i = 0; i < taskList.length; i++) {
      list.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
            toY: double.parse(attendenceList[i].value!),
            color: Colors.deepOrange)
      ]));
    }
    return list;
  }

  SideTitles get bottomTilesTask => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = "";
        switch (value.toInt()) {
          case 0:
            text = "1";
            break;
          case 1:
            text = "2";
            break;
          case 2:
            text = "3";
            break;
          case 3:
            text = "4";
            break;
          case 4:
            text = "5";
            break;
          case 5:
            text = "6";
            break;
          case 6:
            text = "7";
            break;
        }
        return Text(
          text,
          style: const TextStyle(fontSize: 10),
        );
      });

  List<BarChartGroupData> _chartGroup() {
    List<BarChartGroupData> list =
        List<BarChartGroupData>.empty(growable: true);
    for (int i = 0; i < attendenceList.length; i++) {
      list.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
            toY: double.parse(attendenceList[i].value!),
            color: Colors.deepOrange)
      ]));
    }
    return list;
  }

  SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = "";
        switch (value.toInt()) {
          case 0:
            text = "1";
            break;
          case 1:
            text = "2";
            break;
          case 2:
            text = "3";
            break;
          case 3:
            text = "4";
            break;
          case 4:
            text = "5";
            break;
          case 5:
            text = "6";
            break;
          case 6:
            text = "7";
            break;
        }
        return Text(
          text,
          style: const TextStyle(fontSize: 10),
        );
      });

  Future<void> _dialogBuilder(
      BuildContext context, HomeScreenProvider imageProvider) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SizedBox(
            height: 150.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    imageProvider.pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.picture_in_picture_sharp),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Picked Icon from Gallery",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () async {
                      // Capture a photo
                      imageProvider.pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.camera_alt),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Picked Image from Camera",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, String> getWeekStartAndEndDates(DateTime currentDate) {
    final currentWeekday = currentDate.weekday;
    final startDateTime =
        currentDate.subtract(Duration(days: currentWeekday - 1));
    String startFormattedDate = DateFormat('yyyy-MM-dd').format(startDateTime);
    final endDateTime = startDateTime.add(const Duration(days: 4));
    String endFormattedDate = DateFormat('yyyy-MM-dd').format(endDateTime);
    return {'start_date': startFormattedDate, 'end_date': endFormattedDate};
  }

  getEmployee() async {
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      employee.clear();
      for (var element in snapshot.docs) {
        employee.add(element);
        setState(() {});
      }
    });
  }
}
