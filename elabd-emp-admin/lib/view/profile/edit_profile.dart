import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/providers/add_employe_provider.dart';
import 'package:elabd_ems_admin/services/internet_check.dart';
import 'package:elabd_ems_admin/view/profile/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/pick_image.dart';

// ignore: must_be_immutable
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
  String? image;

  @override
  void initState() {
    if (widget.userData != null) {
      nameController.text = widget.userData!['name'];
      contactController.text = widget.userData!['contact'];
      addressController.text = widget.userData!['address'];
      image = widget.userData!['image'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    PickImage imageProvider = Provider.of<PickImage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        title: "Edit Profile",
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySize.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
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
                        'Change Image',
                        style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              fieldWidget(
                  title: 'Name',
                  controller: nameController,
                  hintText: 'Full name'),
              fieldWidget(
                  title: 'Contact',
                  controller: contactController,
                  textInputType: TextInputType.phone,
                  hintText: 'Phone number'),
              fieldWidget(
                  title: 'Address',
                  controller: addressController,
                  hintText: 'Address'),
              const SizedBox(
                height: 50,
              ),
              ButtonWidget(
                  title: 'Update',
                  fontSize: MySize.size12,
                  ontap: () async {
                    if (image == null) {
                      getFlushBar(context, title: 'Updated Image is requied');
                    } else if (nameController.text.isEmpty) {
                      getFlushBar(context, title: 'Updated Name is requied');
                    } else if (contactController.text.isEmpty) {
                      getFlushBar(context, title: 'Updated Contact is requied');
                    } else if (addressController.text.isEmpty) {
                      getFlushBar(context, title: 'Updated Address is requied');
                    } else {
                      bool isConnected = await checkInternetConnection();
                      if (isConnected) {
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
                        }).then((value) {
                          getFlushBar(context, title: 'Updated Successfully');
                          image = '';
                          nameController.clear();
                          contactController.clear();
                          addressController.clear();
                        }).onError((error, stackTrace) {
                          getFlushBar(context, title: 'Error $error');
                        });
                      } else {
                        showNoInternetDialog(context);
                      }
                    }
                  })
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
