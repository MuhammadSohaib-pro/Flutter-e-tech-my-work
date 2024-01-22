import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/providers/add_employe_provider.dart';
import 'package:elabd_ems_admin/services/internet_check.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:elabd_ems_admin/view/manage_task_view/components/button_comp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddNewEmploye extends StatefulWidget {
  Map<String, dynamic>? employeeDetails;
  AddNewEmploye({super.key, this.employeeDetails});

  @override
  State<AddNewEmploye> createState() => _AddNewEmployeState();
}

class _AddNewEmployeState extends State<AddNewEmploye> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final joinDateController = TextEditingController();
  final passwordController = TextEditingController();
  final salaryController = TextEditingController();
  ValueNotifier<bool> obsecureText = ValueNotifier<bool>(true);

  AddEmployeProvider employeProvider = AddEmployeProvider();

  String? image;
  String? _selectedTeam;
  List<String> _teamNames = [];
  // List<String> _customTeamNames = [
  //   'admin',
  //   'flutter',
  //   ''
  // ];
  List<String> _teamIds = [];
  String? selectedTeamId;
  bool isNotEmpty = false;
  String? id;
  String? teamId;

  final ref = FirebaseFirestore.instance.collection('teams').snapshots();
  Map<String, dynamic>? employeeDetails;
  @override
  void initState() {
    super.initState();
    if (widget.employeeDetails != null) {
      nameController.text = widget.employeeDetails!['name'] ?? '';
      emailController.text = widget.employeeDetails!['email'] ?? '';
      contactController.text = widget.employeeDetails!['contact'] ?? '';
      addressController.text = widget.employeeDetails!['address'] ?? '';
      joinDateController.text = widget.employeeDetails!['joinDate'] ?? '';
      passwordController.text = widget.employeeDetails!['password'] ?? '';
      employeeTypeValue = widget.employeeDetails!['type'] ?? '';
      salaryController.text = widget.employeeDetails!['salary'] ?? '';
      _selectedTeam = widget.employeeDetails!['team'] ?? '';
      image = widget.employeeDetails!['image'] ?? '';
      id = widget.employeeDetails!['id'] ?? '';
      teamId = widget.employeeDetails!['teamId'] ?? '';
      isNotEmpty = true;
    }
    print('My Team Id is $teamId');
  }

  final List<String> employeeTypeList = [
    'Senior',
    'Junior',
    'Intern',
  ];
  String? employeeTypeValue;

  @override
  void dispose() {
    image = null;
    nameController.dispose();
    emailController.dispose();
    contactController.dispose();
    addressController.dispose();
    employeeTypeValue = null;

    _selectedTeam = null;
    salaryController.dispose();
    joinDateController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future joinDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null) {
      joinDateController.text = '${picked.day}-${picked.month}-${picked.year}';
      // String formattedDate = DateFormat('dd MMM, yyyy').format(picked);
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      joinDateController.text = formattedDate;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    employeProvider = Provider.of<AddEmployeProvider>(context);
    return Scaffold(
      appBar: AppBarWidget(
        title: isNotEmpty ? 'Edit Employee' : 'Add Employe',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MySize.size20,
              ),
              Consumer<AddEmployeProvider>(
                  builder: (context, imageProvider, child) {
                return Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectImageSource(context, imageProvider);
                        },
                        child: CircleAvatar(
                            radius: MySize.size38,
                            backgroundColor: Colors.transparent,
                            backgroundImage: const AssetImage(
                              AppIcons.profileCircle,
                            ),
                            child: imageProvider.profileImage != null
                                ? CircleAvatar(
                                    radius: MySize.size34,
                                    backgroundImage: FileImage(
                                      imageProvider.profileImage!,
                                    ),
                                  )
                                : image != null
                                    ? CircleAvatar(
                                        radius: MySize.size34,
                                        backgroundImage: NetworkImage(
                                          image!,
                                        ),
                                      )
                                    : image == null
                                        ? Container(
                                            height: MySize.size60,
                                            width: MySize.size60,
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 8,
                                                      spreadRadius: 0,
                                                      offset:
                                                          const Offset(1, 1),
                                                      color: blackColor
                                                          .withOpacity(0.20))
                                                ]),
                                            child: Center(
                                                child: Image.asset(
                                              AppIcons.add,
                                              height: MySize.size20,
                                              width: MySize.size20,
                                            )),
                                          )
                                        : Container(
                                            height: MySize.size60,
                                            width: MySize.size60,
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 8,
                                                      spreadRadius: 0,
                                                      offset:
                                                          const Offset(1, 1),
                                                      color: blackColor
                                                          .withOpacity(0.20))
                                                ]),
                                            child: Center(
                                                child: Image.asset(
                                              AppIcons.add,
                                              height: MySize.size20,
                                              width: MySize.size20,
                                            )),
                                          )),
                      ),
                      SizedBox(
                        height: MySize.size15,
                      ),
                      Text(
                        'Add image',
                        style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: MySize.size30,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldWidget(
                          title: 'Full Name',
                          controller: nameController,
                          hintText: 'Type full name'),
                      isNotEmpty
                          ? const SizedBox(
                              height: 0,
                              width: 0,
                            )
                          : fieldWidget(
                              title: 'Email',
                              controller: emailController,
                              hintText: 'Type email',
                              textInputType: TextInputType.emailAddress),
                      fieldWidget(
                          title: 'Contact',
                          controller: contactController,
                          hintText: 'Type phone number',
                          textInputType: TextInputType.number),
                      fieldWidget(
                          title: 'Address',
                          controller: addressController,
                          hintText: 'Type Address'),

                      Text(
                        'Select Team',
                        style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                      ),
                      SizedBox(
                        height: MySize.size4,
                      ),
                      // Container(
                      //   height: MySize.size54,
                      //   decoration:
                      //       BoxDecoration(color: whiteColor, boxShadow: [
                      //     BoxShadow(
                      //         color: blackColor.withOpacity(0.15),
                      //         blurRadius: 10,
                      //         spreadRadius: 0,
                      //         offset: const Offset(-1, -1))
                      //   ]),
                      //   child: DropdownButtonFormField2<String>(
                      //     items: selectTeamList
                      //         .map((item) => DropdownMenuItem<String>(
                      //               value: item,
                      //               child: Text(
                      //                 item,
                      //                 style: const TextStyle(
                      //                   fontSize: 14,
                      //                 ),
                      //               ),
                      //             ))
                      //         .toList(),
                      //     onChanged: (String? value) {
                      //       setState(() {
                      //         selectedTeam = value!;
                      //       });
                      //     },
                      //     isExpanded: true,
                      //     value: selectedTeam,
                      //     hint: Text(
                      //       'Team',
                      //       style: poppinMedium.copyWith(
                      //           color: lightGrey, fontSize: MySize.size16),
                      //     ),
                      //     decoration: const InputDecoration(
                      //         contentPadding: EdgeInsets.only(right: 10),
                      //         border: OutlineInputBorder(
                      //           borderSide: BorderSide.none,
                      //         )),
                      //   ),
                      // ),

                      /// fetch data from firebase collection and show it on drope down
                      StreamBuilder<QuerySnapshot>(
                        stream: ref,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text('Error loading teams');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Text('No teams found');
                          } else if (snapshot.data!.docs.isEmpty) {
                            return const Text(
                              'No thing found ',
                            );
                          } else {
                            _teamNames = snapshot.data!.docs
                                .map((doc) => doc['teamName'] as String)
                                .toList();
                            _teamIds = snapshot.data!.docs
                                .map((doc) => doc['teamId'] as String)
                                .toList();
                            return Container(
                              height: MySize.size54,
                              decoration:
                                  BoxDecoration(color: whiteColor, boxShadow: [
                                BoxShadow(
                                    color: blackColor.withOpacity(0.15),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: const Offset(-1, -1))
                              ]),
                              child: DropdownButtonFormField2<String>(
                                items: _teamNames
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
                                    _selectedTeam = value;
                                    // Find the index of the selected team name
                                    int selectedIndex =
                                        _teamNames.indexOf(value!);
                                    // Use the corresponding team ID from the _teamIds list
                                    selectedTeamId = _teamIds[selectedIndex];
                                    debugPrint(
                                        'Selected Team ID: $selectedTeamId');
                                    debugPrint(
                                        'Selected Team is $_selectedTeam');
                                  });
                                },
                                isExpanded: true,
                                value: _selectedTeam,
                                hint: Text(
                                  'select',
                                  style: poppinMedium.copyWith(
                                      fontSize: MySize.size14,
                                      color: lightGrey),
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        right: MySize.size16,
                                        left: MySize.size16),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                              ),
                            );
                          }
                        },
                      ),

                      SizedBox(
                        height: MySize.size8,
                      ),
                      fieldWidget(
                          title: 'Salary',
                          controller: salaryController,
                          textInputType: TextInputType.number,
                          hintText: 'Salary'),
                      // fieldWidget(
                      //     title: 'Employee Type',
                      //     controller: typeController,
                      //     hintText: 'Your type'),

                      Text(
                        'Employee Type',
                        style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                      ),
                      SizedBox(
                        height: MySize.size8,
                      ),
                      Container(
                        height: MySize.size54,
                        decoration:
                            BoxDecoration(color: whiteColor, boxShadow: [
                          BoxShadow(
                              color: blackColor.withOpacity(0.15),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: const Offset(-1, -1))
                        ]),
                        child: DropdownButtonFormField2<String>(
                          items: employeeTypeList
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
                            employeeTypeValue = value;
                            setState(() {});
                            print(employeeTypeValue);
                          },
                          isExpanded: true,
                          value: employeeTypeValue,
                          hint: Text(
                            'select employee type',
                            style: poppinMedium.copyWith(
                                fontSize: MySize.size14, color: lightGrey),
                          ),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  right: MySize.size16, left: MySize.size16),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: MySize.size10,
                      ),
                      Text(
                        'Join Date',
                        style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                      ),
                      SizedBox(
                        height: MySize.size8,
                      ),
                      // TextFieldWidget(
                      //     controller: joinDateController,
                      //     borderRadius: 0,
                      //     readOnly: true,
                      //     sufixIcon: GestureDetector(
                      //         onTap: () {
                      //           joinDatePicker(context);
                      //         },
                      //         child: Icon(Icons.calendar_month)),
                      //     hintText: 'Join date'),

                      GestureDetector(
                        onTap: () {
                          joinDatePicker(context);
                        },
                        child: Container(
                          height: MySize.size56,
                          width: MySize.screenWidth,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: blackColor.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(-1, -1))
                          ]),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: MySize.size30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  joinDateController.text.isNotEmpty
                                      ? joinDateController.text
                                      : 'Join Date',
                                  style: poppinMedium.copyWith(
                                      fontSize: MySize.size14,
                                      color: joinDateController.text.isNotEmpty
                                          ? blackColor
                                          : lightGrey),
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

                      SizedBox(
                        height: MySize.size10,
                      ),
                      isNotEmpty
                          ? const SizedBox(
                              height: 0,
                              width: 0,
                            )
                          : Text(
                              'Password',
                              style:
                                  poppinBold.copyWith(fontSize: MySize.size14),
                            ),
                      SizedBox(
                        height: MySize.size8,
                      ),
                      isNotEmpty
                          ? const SizedBox(
                              height: 0,
                              width: 0,
                            )
                          : ValueListenableBuilder(
                              valueListenable: obsecureText,
                              builder: (context, value, child) {
                                return TextFieldWidget(
                                    isObsecure: obsecureText.value,
                                    borderRadius: 0,
                                    sufixIcon: GestureDetector(
                                      onTap: () {
                                        obsecureText.value =
                                            !obsecureText.value;
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(MySize.size20),
                                        child: Image.asset(
                                          height: MySize.size20,
                                          width: MySize.size20,
                                          color: lightGrey,
                                          obsecureText.value
                                              ? AppIcons.eyeoff
                                              : AppIcons.eye,
                                        ),
                                      ),
                                    ),
                                    keyBoadType: TextInputType.text,
                                    controller: passwordController,
                                    hintText: 'Type password');
                              },
                            ),
                    ],
                  )),
              SizedBox(
                height: MySize.screenHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonComp(
                    title: 'Cancel',
                    borderColor: borderColor,
                    backColor: whiteColor,
                    textColor: borderColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    bordeRadius: 0,
                  ),
                  SizedBox(
                    width: MySize.size30,
                  ),
                  // ButtonComp(
                  //   title: 'Add',
                  //   onTap: () async {
                  //     if (employeProvider.profileImage == null) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Image is required');
                  //     } else if (nameController.text.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Full name is required');
                  //     } else if (emailController.text.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Email is required');
                  //     } else if (contactController.text.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warnign! Contact is required');
                  //     } else if (addressController.text.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Address is required');
                  //     } else if (typeController.text.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Type is required');
                  //     } else if (statusController.text.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Status is required');
                  //     } else if (joinDateController.text.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Join Date is required');
                  //     } else if (emailController.text.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Password is required');
                  //     } else if (_selectedTeam == null ||
                  //         _selectedTeam!.isEmpty) {
                  //       getFlushBar(context,
                  //           title: 'Warning! Please select your ream');
                  //     } else {
                  //       String imageurl =
                  //           await employeProvider.uploadImagetoFirebaseStorage(
                  //               employeProvider.profileImage!);
                  //       // ignore: use_build_context_synchronously
                  //       employeProvider.addNewEmploye(
                  //         context: context,
                  //         address: addressController.text.toString(),
                  //         contact: contactController.text.toString(),
                  //         email: emailController.text.toString(),
                  //         fullName: nameController.text.toString(),
                  //         imageUrl: imageurl,
                  //         joinDate: joinDateController.text.toString(),
                  //         status: statusController.text.toString(),
                  //         team: _selectedTeam,
                  //         type: typeController.text.toString(),
                  //         teamId: selectedTeamId,
                  //       );
                  //     }
                  //   },
                  //   bordeRadius: 0,
                  // ),

                  isNotEmpty
                      ? ButtonComp(
                          title: 'Update',
                          onTap: () async {
                            if (image == null) {
                              getFlushBar(context,
                                  title: 'Please provide updated image');
                            } else if (nameController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide updated Name');
                            } else if (contactController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide updated Contact');
                            } else if (addressController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide updated Address');
                            } else if (employeeTypeValue == null &&
                                employeeTypeValue == '') {
                              getFlushBar(context,
                                  title: 'Please provide updated Status');
                            } else if (_selectedTeam!.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide updated Team');
                            } else if (salaryController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide updated Salary');
                            } else if (joinDateController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Please provide updated JoinDate');
                            } else {
                              bool isConnected =
                                  await checkInternetConnection();
                              if (isConnected) {
                                SmartDialog.showLoading();
                                // image == null;
                                if (employeProvider.profileImage != null) {
                                  image = await employeProvider
                                      .uploadImagetoFirebaseStorage(
                                    employeProvider.profileImage!,
                                  );
                                }
                                FirebaseFirestore.instance
                                    .collection('employees')
                                    .doc(id)
                                    .update({
                                  'image': image,
                                  'name': nameController.text.toString(),
                                  'contact': contactController.text.toString(),
                                  'address': addressController.text.toString(),
                                  'type': employeeTypeValue.toString(),
                                  'team': _selectedTeam,
                                  'teamId': selectedTeamId,
                                  'salary': salaryController.text.toString(),
                                  'joinDate':
                                      joinDateController.text.toString(),
                                }).then((value) {
                                  SmartDialog.dismiss();
                                  getFlushBar(context,
                                      title: 'Updated Successflly',
                                      color: primaryColor,
                                      isSuccess: true);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarView(
                                                index: 2,
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
                          bordeRadius: 0,
                        )
                      : ButtonComp(
                          title: 'Add',
                          onTap: () async {
                            if (employeProvider.profileImage == null) {
                              getFlushBar(context,
                                  title: 'Warning! Image is required');
                            } else if (nameController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Warning! Full name is required');
                            } else if (emailController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Warning! Email is required');
                            } else if (contactController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Warning! Contact is required');
                            } else if (addressController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Warning! Address is required');
                            } else if (employeeTypeValue == null &&
                                employeeTypeValue == '') {
                              getFlushBar(context,
                                  title: 'Warning! Status is required');
                            } else if (joinDateController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Warning! Join Date is required');
                            } else if (salaryController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Warning! Salary is required');
                            } else if (passwordController.text.isEmpty) {
                              getFlushBar(context,
                                  title: 'Warning! Password is required');
                            } else if (_selectedTeam == null ||
                                _selectedTeam!.isEmpty) {
                              getFlushBar(context,
                                  title: 'Warning! Please select your team');
                            } else {
                              bool isConnected =
                                  await checkInternetConnection();

                              if (isConnected) {
                                String imageurl = await employeProvider
                                    .uploadImagetoFirebaseStorage(
                                        employeProvider.profileImage!);

                                var userID =
                                    FirebaseAuth.instance.currentUser!.uid;

                                // ignore: use_build_context_synchronously
                                employeProvider
                                    .addNewEmploye(
                                  id: userID,
                                  context: context,
                                  address: addressController.text.toString(),
                                  contact: contactController.text.toString(),
                                  email: emailController.text.toString(),
                                  fullName: nameController.text.toString(),
                                  imageUrl: imageurl,
                                  joinDate: joinDateController.text.toString(),
                                  type: employeeTypeValue.toString(),
                                  salary: salaryController.text.toString(),
                                  team: _selectedTeam,
                                  teamId: selectedTeamId,
                                  password: passwordController.text.toString(),
                                )
                                    .then((value) {
                                  nameController.clear();
                                  image = null;
                                  emailController.clear();
                                  contactController.clear();
                                  addressController.clear();
                                  employeeTypeValue = null;
                                  _selectedTeam = null;
                                  salaryController.clear();
                                  joinDateController.clear();
                                  passwordController.clear();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarView(
                                                index: 2,
                                              )));
                                });
                              } else {
                                showNoInternetDialog(context);
                              }
                            }
                          },
                          bordeRadius: 0,
                        ),
                ],
              ),
              SizedBox(
                height: MySize.screenHeight * 0.05,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> selectImageSource(
      BuildContext context, AddEmployeProvider imageProvider) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Select Image Source',
              style: poppinBold.copyWith(fontSize: MySize.size14),
            ),
            content: Column(children: [
              SizedBox(
                height: MySize.size40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      imageProvider.pickImage(ImageSource.camera, context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      imageProvider.pickImage(ImageSource.gallery, context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.camera),
                    ),
                  ),
                ],
              )
            ]),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }

  Widget fieldWidget(
      {required String title,
      required TextEditingController controller,
      required String hintText,
      TextInputType textInputType = TextInputType.name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: poppinSemiBold.copyWith(fontSize: MySize.size14),
        ),
        SizedBox(
          height: MySize.size8,
        ),
        TextFieldWidget(
            keyBoadType: textInputType,
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return '';
            //   }
            //   return '';
            // },
            borderRadius: 0,
            controller: controller,
            hintText: hintText),
        SizedBox(
          height: MySize.size10,
        ),
      ],
    );
  }
}
