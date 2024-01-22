import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elabd_ems_admin/core/multi_line_textfield_widget.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/providers/add_task_provider.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../services/internet_check.dart';

class AddTask extends StatefulWidget {
  final Map<String, dynamic>? taskData;
  const AddTask({super.key, this.taskData});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final taksTitleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  // Future startDatePicker(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       initialDatePickerMode: DatePickerMode.day,
  //       firstDate: DateTime(1950),
  //       lastDate: DateTime(2101));
  //   if (picked != null) {
  //     startDateController.text = '${picked.day}-${picked.month}-${picked.year}';
  //     // String formattedDate = DateFormat('dd MMM, yyyy').format(picked);
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
  //     startDateController.text = formattedDate;
  //   }
  // }

  // Future endDatePicker(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       initialDatePickerMode: DatePickerMode.day,
  //       firstDate: DateTime(1950),
  //       lastDate: DateTime(2101));
  //   if (picked != null) {
  //     endDateController.text = '${picked.day}-${picked.month}-${picked.year}';
  //     // String formattedDate = DateFormat('dd MMM, yyyy').format(picked);
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
  //     endDateController.text = formattedDate;
  //   }
  // }
  Future startDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null) {
      if (selectedEndDate != null && picked.isAfter(selectedEndDate!)) {
        // Invalid start date, show error message
        getFlushBar(context, title: 'Start date cannot be after end date.');
      } else {
        setState(() {
          selectedStartDate = picked;
          String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
          startDateController.text = formattedDate;
        });
      }
    }
  }

  Future endDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null) {
      if (selectedStartDate != null && picked.isBefore(selectedStartDate!)) {
        getFlushBar(context, title: 'End date cannot be before start date.');
      } else {
        setState(() {
          selectedEndDate = picked;
          String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
          endDateController.text = formattedDate;
        });
      }
    }
  }

  final List<String> taskPirorityList = [
    'Urgent',
    'Major',
  ];

  String? taskPirorityValue;
  List<String> assignToList = [];
  String? selectedUser;
  String? selectedUserId;
  final searchPirorityController = TextEditingController();

  // Function to get the ID of the selected user
  String? getSelectedUserId(
      String selectedUserName, List<QueryDocumentSnapshot> docs) {
    final selectedUserDoc = docs.firstWhere(
      (doc) => doc['name'] == selectedUserName,
    );
    return selectedUserDoc.id;
  }

  String? fcmToken;
  bool isNotEmpty = false;

  @override
  void initState() {
    super.initState();
    if (widget.taskData != null) {
      taksTitleController.text = widget.taskData!['taskTitle'] ?? '';
      selectedUser = widget.taskData!['selectedUserName'] ?? '';
      taskPirorityValue = widget.taskData!['taskPirority'] ?? '';
      startDateController.text = widget.taskData!['startDate'] ?? '';
      endDateController.text = widget.taskData!['endDate'] ?? '';
      descriptionController.text = widget.taskData!['taskDetail'] ?? '';
      selectedUserId = widget.taskData!['assignedUserId'] ?? '';
      isNotEmpty = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    taksTitleController.dispose();
    assignToList.clear();
    taskPirorityList.clear();
    startDateController.dispose();
    endDateController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddTaskProvider taskProvider = Provider.of<AddTaskProvider>(context);
    final todayDate = DateTime.now();
    final formattedDate = DateFormat('dd MMM y').format(todayDate);
    MySize().init(context);
    return Scaffold(
      appBar: AppBarWidget(
        title: isNotEmpty ? 'Edit Tasks' : 'Add Tasks',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size14),
          child: Column(
            children: [
              SizedBox(
                height: MySize.size20,
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Title',
                      style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                    ),
                    SizedBox(
                      height: MySize.size8,
                    ),
                    TextFieldWidget(
                      controller: taksTitleController,
                      hintText: 'Title',
                      borderRadius: MySize.size0,
                    ),
                    SizedBox(
                      height: MySize.size10,
                    ),

                    ////Some code are missing

                    // DropdownButtonFormField2<String>(
                    //   items: taskPirorityList
                    //       .map((item) => DropdownMenuItem<String>(
                    //             value: item,
                    //             child: Text(
                    //               item,
                    //               style: const TextStyle(
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //           ))
                    //       .toList(),
                    //   onChanged: (String? value) {
                    //     setState(() {
                    //       selectedPirorityValue = value;
                    //     });
                    //   },
                    //   isExpanded: true,
                    //   value: selectedPirorityValue,
                    //   hint: const Text('select vlaue'),
                    //   decoration: InputDecoration(
                    //       contentPadding:
                    //           const EdgeInsets.symmetric(vertical: 16),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //       )),
                    // ),

                    SizedBox(
                      height: MySize.size10,
                    ),
                    Text(
                      'Assign to',
                      style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                    ),
                    SizedBox(
                      height: MySize.size8,
                    ),
                    // TextFieldWidget(
                    //     sufixIcon:
                    //         const Icon(Icons.keyboard_arrow_down_outlined),
                    //     controller: taskIdController,
                    //     hintText: 'assign to'),
                    // Container(
                    //   height: MySize.size54,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(color: whiteColor, boxShadow: [
                    //     BoxShadow(
                    //         color: blackColor.withOpacity(0.15),
                    //         blurRadius: 10,
                    //         spreadRadius: 0,
                    //         offset: const Offset(-1, -1))
                    //   ]),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton2<String>(
                    //       isExpanded: true,
                    //       hint: Text('Search',
                    //           style: poppinMedium.copyWith(
                    //               color: lightGrey, fontSize: MySize.size14)),
                    //       items: assignToList
                    //           .map(
                    //             (item) => DropdownMenuItem(
                    //               value: item,
                    //               child: Text(
                    //                 item,
                    //                 style: const TextStyle(
                    //                   fontSize: 14,
                    //                 ),
                    //               ),
                    //             ),
                    //           )
                    //           .toList(),
                    //       value: assignToValue,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           assignToValue = value;
                    //         });
                    //       },
                    //       buttonStyleData: ButtonStyleData(
                    //         padding: const EdgeInsets.symmetric(horizontal: 16),
                    //         height: MySize.size64,
                    //         width: 200,
                    //       ),
                    //       dropdownStyleData: DropdownStyleData(
                    //         maxHeight: MySize.scaleFactorHeight * 250,
                    //       ),
                    //       menuItemStyleData: const MenuItemStyleData(
                    //         height: 40,
                    //       ),
                    //       dropdownSearchData: DropdownSearchData(
                    //         searchController: searchPirorityController,
                    //         searchInnerWidgetHeight: 50,
                    //         searchInnerWidget: Container(
                    //           height: 50,
                    //           padding: const EdgeInsets.only(
                    //             top: 8,
                    //             bottom: 4,
                    //             right: 8,
                    //             left: 8,
                    //           ),
                    //           child: TextFormField(
                    //             expands: true,
                    //             maxLines: null,
                    //             controller: searchPirorityController,
                    //             decoration: InputDecoration(
                    //               isDense: true,
                    //               contentPadding: const EdgeInsets.symmetric(
                    //                 horizontal: 10,
                    //                 vertical: 8,
                    //               ),
                    //               hintText: 'Search for an item...',
                    //               hintStyle: const TextStyle(fontSize: 12),
                    //               border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(8),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         searchMatchFn: (item, searchValue) {
                    //           return item.value
                    //               .toString()
                    //               .contains(searchValue);
                    //         },
                    //       ),
                    //       //This to clear the search value when you close the menu
                    //       onMenuStateChange: (isOpen) {
                    //         if (!isOpen) {
                    //           searchPirorityController.clear();
                    //         }
                    //       },
                    //     ),
                    //   ),
                    // ),

                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('employees')
                          .where('role', isEqualTo: 'user')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Error loading users');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text('No users found');
                        } else {
                          assignToList = snapshot.data!.docs
                              .map((doc) => doc['name'] as String)
                              .toList();

                          return Container(
                            height: MySize.size54,
                            width: double.infinity,
                            decoration:
                                BoxDecoration(color: whiteColor, boxShadow: [
                              BoxShadow(
                                  color: blackColor.withOpacity(0.15),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: const Offset(-1, -1))
                            ]),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                value: selectedUser,
                                hint: Text(
                                  'Search',
                                  style: poppinMedium.copyWith(
                                      color: lightGrey,
                                      fontSize: MySize.size14),
                                ),
                                items: assignToList
                                    .map(
                                      (item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedUser = value;
                                    selectedUserId = getSelectedUserId(
                                        value!, snapshot.data!.docs);
                                    debugPrint(
                                        'Selected user ID: $selectedUserId');
                                    debugPrint(selectedUser);

                                    // Here's where we retrieve the fcmToken based on the selectedUserId
                                    final userDocRef = FirebaseFirestore
                                        .instance
                                        .collection('employees')
                                        .doc(selectedUserId);
                                    userDocRef.get().then((userSnapshot) {
                                      if (userSnapshot.exists) {
                                        fcmToken =
                                            userSnapshot['fcmToken'] as String?;
                                        if (fcmToken != null) {
                                          // Use the fcmToken for further actions (e.g., sending notifications)
                                          debugPrint(
                                              'Selected user fcmToken: $fcmToken');
                                        } else {
                                          debugPrint(
                                              'Selected user does not have an fcmToken');
                                        }
                                      } else {
                                        debugPrint(
                                            'Selected user document does not exist');
                                      }
                                    });
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  height: MySize.size64,
                                  width: 200,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: MySize.scaleFactorHeight * 250,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),

                                /* If you want to search a specific user then uncomment the code  */
                                //  dropdownSearchData: DropdownSearchData(
                                //   searchController: searchPirorityController,
                                //   searchInnerWidgetHeight:
                                //       50, // Set a non-null value here
                                //   searchInnerWidget: Container(
                                //     height: 50,
                                //     padding: const EdgeInsets.only(
                                //       top: 8,
                                //       bottom: 4,
                                //       right: 8,
                                //       left: 8,
                                //     ),
                                //     child: TextFormField(
                                //       expands: true,
                                //       maxLines: null,
                                //       controller: searchPirorityController,
                                //       decoration: InputDecoration(
                                //         isDense: true,
                                //         contentPadding:
                                //             const EdgeInsets.symmetric(
                                //           horizontal: 10,
                                //           vertical: 8,
                                //         ),
                                //         hintText: 'Search for an item...',
                                //         hintStyle:
                                //             const TextStyle(fontSize: 12),
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(8),
                                //         ),
                                //       ),
                                //       onChanged: (value) {
                                //         setState(() {
                                //           selectedUser = value;
                                //           searchPirorityController.text = value;
                                //           selectedUser =
                                //               value; // Set selectedUser here
                                //         });
                                //       },
                                //     ),
                                //   ),
                                //   searchMatchFn: (item, searchValue) {
                                //     return item.value
                                //         .toString()
                                //         .contains(searchValue);
                                //   },
                                // ),

                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    searchPirorityController.clear();
                                  }
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),

                    SizedBox(
                      height: MySize.size10,
                    ),
                    Text(
                      'Task Pirority',
                      style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                    ),
                    SizedBox(
                      height: MySize.size8,
                    ),
                    Container(
                      height: MySize.size54,
                      decoration: BoxDecoration(color: whiteColor, boxShadow: [
                        BoxShadow(
                            color: blackColor.withOpacity(0.15),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(-1, -1))
                      ]),
                      child: DropdownButtonFormField2<String>(
                        items: taskPirorityList
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            taskPirorityValue = value;
                          });
                        },
                        isExpanded: true,
                        value: taskPirorityValue,
                        hint: Text(
                          'select',
                          style: poppinMedium.copyWith(
                              fontSize: MySize.size14, color: lightGrey),
                        ),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(right: MySize.size16),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),

                    SizedBox(
                      height: MySize.size10,
                    ),
                    Text(
                      'Assign to',
                      style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                    ),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Date',
                              style: poppineRegular.copyWith(
                                  fontSize: MySize.size12),
                            ),
                            SizedBox(
                              height: MySize.size10,
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     print('hello rafi');
                            //   },
                            //   child: Container(
                            //     height: MySize.size56,
                            //     width: MySize.screenWidth,
                            //     child: TextFieldWidget(
                            //       horizontalPadding: 10,
                            //       borderRadius: 0,
                            //       readOnly: true,
                            //       controller: startDateController,
                            //       hintText: formattedDate,
                            //       sufixIcon: Padding(
                            //         padding: EdgeInsets.all(MySize.size15),
                            //         child: GestureDetector(
                            //           onTap: () {
                            //             startDatePicker(context);
                            //           },
                            //           child: Image.asset(
                            //             AppIcons.calander,
                            //             height: MySize.size15,
                            //             width: MySize.size15,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // )

                            GestureDetector(
                              onTap: () {
                                startDatePicker(context);
                              },
                              child: Container(
                                height: MySize.size56,
                                width: MySize.screenWidth,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: blackColor.withOpacity(0.15),
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: const Offset(-1, -1))
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MySize.size10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        startDateController.text.isNotEmpty
                                            ? startDateController.text
                                                .toString()
                                            : formattedDate,
                                      ),
                                      Image.asset(
                                        AppIcons.calander,
                                        height: MySize.size25,
                                        width: MySize.size25,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          width: MySize.size20,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Date',
                              style: poppineRegular.copyWith(
                                  fontSize: MySize.size12),
                            ),
                            SizedBox(
                              height: MySize.size10,
                            ),
                            // TextFieldWidget(
                            //   borderRadius: 0,
                            //   readOnly: true,
                            //   horizontalPadding: 10,
                            //   controller: endDateController,
                            //   hintText: formattedDate,
                            //   sufixIcon: Padding(
                            //     padding: EdgeInsets.all(MySize.size15),
                            //     child: GestureDetector(
                            //       onTap: () {
                            //         endDatePicker(context);
                            //       },
                            //       child: Image.asset(
                            //         AppIcons.calander,
                            //         height: MySize.size15,
                            //         width: MySize.size15,
                            //       ),
                            //     ),
                            //   ),
                            // )

                            GestureDetector(
                              onTap: () {
                                endDatePicker(context);
                              },
                              child: Container(
                                height: MySize.size56,
                                width: MySize.screenWidth,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: blackColor.withOpacity(0.15),
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: const Offset(-1, -1))
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MySize.size10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        endDateController.text.isNotEmpty
                                            ? endDateController.text.toString()
                                            : formattedDate,
                                      ),
                                      Image.asset(
                                        AppIcons.calander,
                                        height: MySize.size25,
                                        width: MySize.size25,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          
                          
                          ],
                        ))
                      ],
                    ),
                    SizedBox(
                      height: MySize.size20,
                    ),
                    Text(
                      'Add Task Detail',
                      style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                    ),
                    SizedBox(
                      height: MySize.size10,
                    ),
                    MultiLineTextFieldWidget(
                      maxLines: 10,
                      controller: descriptionController,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MySize.size20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: MySize.size40,
                      width: MySize.size96,
                      decoration:
                          BoxDecoration(border: Border.all(color: borderColor)),
                      child: const Center(child: Text('Cancel')),
                    ),
                  ),
                  SizedBox(
                    width: MySize.size60,
                  ),
                  isNotEmpty
                      ? GestureDetector(
                          onTap: () async {
                            var id = widget.taskData!['taskId'];
                            if (taksTitleController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide Updated title');
                            } else if (selectedUser!.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please select Updated User');
                            } else if (taskPirorityValue!.isEmpty) {
                              getFlushBar(context,
                                  title:
                                      'Please provide Updated Pirority value');
                            } else if (startDateController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide Updated Start Date');
                            } else if (endDateController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide Updated End Date');
                            } else if (descriptionController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide Updated Description');
                            } else {
                              bool isConnected =
                                  await checkInternetConnection();

                              if (isConnected) {
                                SmartDialog.showLoading();
                                FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(id)
                                    .update({
                                  'taskTitle':
                                      taksTitleController.text.toString(),
                                  'assignedUserId': selectedUserId,
                                  'selectedUserName': selectedUser,
                                  'startDate':
                                      startDateController.text.toString(),
                                  'endDate': endDateController.text.toString(),
                                  'taskDetail':
                                      descriptionController.text.toString(),
                                  'taskId': id,
                                  'taskPirority': taskPirorityValue,
                                }).then((value) {
                                  SmartDialog.dismiss();
                                  getFlushBar(context,
                                      title: 'Updated Successfully',
                                      color: primaryColor,
                                      isSuccess: true);
                                }).then((value) {
                                  taksTitleController.clear();
                                  selectedUser = '';
                                  assignToList.clear();
                                  taskPirorityValue = '';
                                  startDateController.clear();
                                  endDateController.clear();
                                  descriptionController.clear();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarView(
                                                index: 1,
                                              )));
                                }).onError((error, stackTrace) {
                                  SmartDialog.dismiss();
                                  getFlushBar(context, title: 'Error $error');
                                });
                              } else {
                                showNoInternetDialog(context);
                              }
                            }
                          },
                          child: Container(
                            height: MySize.size40,
                            width: MySize.size96,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              'Update',
                              style: poppineRegular.copyWith(color: whiteColor),
                            )),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            if (taksTitleController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide title');
                            } else if (selectedUser == null) {
                              getFlushBar(context,
                                  title: 'Please assign a task');
                            } else if (taskPirorityValue == null) {
                              getFlushBar(context,
                                  title: 'Please select priority');
                            } else if (startDateController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Provide start Date ');
                            } else if (endDateController.text.isEmpty) {
                              getFlushBar(context, title: 'Provide end Date ');
                            } else if (descriptionController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Task detail cannot be empty');
                            } else {
                              bool isConnected =
                                  await checkInternetConnection();
                              if (isConnected) {
                                var id = DateTime.now().millisecondsSinceEpoch;
                                DateTime currentTime = DateTime.now();
                                int unixTimestamp =
                                    currentTime.millisecondsSinceEpoch ~/ 1000;
                                taskProvider
                                    .addNewTask(
                                  context: context,
                                  taskId: id.toString(),
                                  taskStatus: 'Pending',
                                  taskTitle:
                                      taksTitleController.text.toString(),
                                  taskPirority: taskPirorityValue.toString(),
                                  startDate:
                                      startDateController.text.toString(),
                                  endDate: endDateController.text.toString(),
                                  taskDetail:
                                      descriptionController.text.toString(),
                                  // when the user select we add the selected user id in firebase
                                  assignedUserId: selectedUserId,
                                  selecteUser: selectedUser,
                                  unixTimestamp: unixTimestamp,
                                )
                                    .then((value) async {
                                  final data = {
                                    'registration_ids': [fcmToken],
                                    'priority': 'high',
                                    'notification': {
                                      'title': 'New Message',
                                      'body': 'You have assigned a new Task'
                                    }
                                  };

                                  final response = await http.post(
                                    Uri.parse(
                                        'https://fcm.googleapis.com/fcm/send'),
                                    body: jsonEncode(data),
                                    headers: {
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                      'Authorization':
                                          'key=AAAAl8yn4mw:APA91bEZK68EvntCRTTTS7DT7YNb8KiKnVoDjPqRQ_2arUus-MY00PdSDkppe9iakGui2NJiPIW74N8EqN16kjiR9bxJmKTP4zWovCdkt7UJ2dAj8z2qFuuN_anYhHECVh4kVhspBXj9'
                                    },
                                  );

                                  if (response.statusCode == 200) {
                                    debugPrint(
                                        'Notification sent successfully');
                                  } else {
                                    debugPrint(
                                        'Error sending notification: ${response.body}');
                                  }
                                }).then((value) {
                                  taksTitleController.clear();
                                  assignToList.clear();
                                  taskPirorityList.clear();
                                  startDateController.clear();
                                  endDateController.clear();
                                  descriptionController.clear();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarView(
                                                index: 1,
                                              )));
                                });
                              } else {
                                showNoInternetDialog(context);
                              }
                            }
                          },
                          child: Container(
                            height: MySize.size40,
                            width: MySize.size96,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              'Add',
                              style: poppineRegular.copyWith(color: whiteColor),
                            )),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: MySize.size20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
