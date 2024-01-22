import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/custom_app_bar.dart';
import 'package:elabd_tms_app/components/custom_button.dart';
import 'package:elabd_tms_app/components/custom_text.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:elabd_tms_app/providers/pick_image.dart';
import 'package:elabd_tms_app/screens/home/custom_bottom_nav_bar.dart';
import 'package:elabd_tms_app/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../components/text_field_widget.dart';

class EditProfile extends StatefulWidget {
  Map<String, dynamic>? userData;
  EditProfile({Key? key, this.userData}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final joinDateController = TextEditingController();
  final typeController = TextEditingController();
  String? image;

  @override
  void initState() {
    super.initState();
    if (userData != null) {
      nameController.text = userData!['name'];
      contactController.text = userData!['contact'];
      addressController.text = userData!['address'];
      joinDateController.text = userData!['joinDate'];
      typeController.text = userData!['type'];
      image = userData!['image'];
    }
  }

  @override
  Widget build(BuildContext context) {
    PickImage imageProvider = Provider.of<PickImage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Edit Profile",
        textColor: black,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        imageProvider.pickImage();
                      },
                      child: image != null
                          ? CircleAvatar(
                              radius: 34,
                              backgroundImage: NetworkImage(
                                image!,
                              ),
                            )
                          : Container(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(text: 'Change Picture'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              fieldWidget(
                  title: 'Name', controller: nameController, hintText: 'Name'),
              fieldWidget(
                  title: 'Contact',
                  controller: contactController,
                  textInputType: TextInputType.phone,
                  hintText: 'Contact'),
              fieldWidget(
                  title: 'Address',
                  controller: addressController,
                  hintText: 'Address'),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                  width: double.infinity,
                  textColor: white,
                  height: 50,
                  text: 'Update',
                  color: primaryColor,
                  onPressed: () async {
                    if (image == null) {
                      Fluttertoast.showToast(msg: 'Updated Image is requied');
                    } else if (nameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Updated Name is requied');
                    } else if (contactController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Updated Contact is requied');
                    } else if (addressController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Updated Address is requied');
                    } else if (joinDateController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Updated JoinDate is requied');
                    } else if (typeController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Updated Type is requied');
                    } else {
                      // image == null;
                      if (imageProvider.profileImage != null) {
                        image =
                            await imageProvider.uploadImagetoFirebaseStorage(
                          imageProvider.profileImage!,
                        );
                      }
                      var id = FirebaseAuth.instance.currentUser!.uid;
                      FirebaseFirestore.instance
                          .collection('employees')
                          .doc(id)
                          .update({
                        'image': image,
                        'name': nameController.text.toString(),
                        'address': addressController.text.toString(),
                        'contact': contactController.text.toString(),
                        // 'joinDate': joinDateController.text.toString(),
                        // 'type': typeController.text.toString(),
                      }).then((value) {
                        Fluttertoast.showToast(msg: 'Updated Successfully');

                        image = '';
                        nameController.clear();
                        contactController.clear();
                        addressController.clear();
                        joinDateController.clear();
                        typeController.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizedBottomNavigationBar(
                                      index: 4,
                                    )));
                      }).onError((error, stackTrace) {
                        Fluttertoast.showToast(msg: 'Error $error');
                      });
                    }
                  }),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      )),
    );
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
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
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
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
