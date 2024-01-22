import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/services/internet_check.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/add_employe_provider.dart';
import '../manage_task_view/components/button_comp.dart';

class AddNewTeam extends StatelessWidget {
  AddNewTeam({super.key});
  final nameController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AddEmployeProvider employeProvider =
        Provider.of<AddEmployeProvider>(context);
    MySize().init(context);
    return Scaffold(
        appBar: const AppBarWidget(title: 'Add Team'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size16),
              child: Column(children: [
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
                                    radius: MySize.size32,
                                    backgroundImage: FileImage(
                                      imageProvider.profileImage!,
                                    ),
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
                                              offset: const Offset(1, 1),
                                              color:
                                                  blackColor.withOpacity(0.20))
                                        ]),
                                    child: Center(
                                        child: Image.asset(
                                      AppIcons.add,
                                      height: MySize.size20,
                                      width: MySize.size20,
                                    )),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: MySize.size15,
                        ),
                        Text(
                          'Add image',
                          style:
                              poppinSemiBold.copyWith(fontSize: MySize.size14),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(
                  height: MySize.size30,
                ),
                Form(
                    // key: formKey,
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldWidget(
                        title: 'Team Name',
                        controller: nameController,
                        hintText: 'Type team name'),
                    SizedBox(
                      height: MySize.size4,
                    ),
                    SizedBox(
                      height: MySize.size8,
                    ),
                  ],
                )),
                SizedBox(
                  height: MySize.screenHeight * 0.2,
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
                    ButtonComp(
                      title: 'Add',
                      backColor: primaryColor,
                      textColor: whiteColor,
                      onTap: () async {
                        bool isInternetConnect =
                            await checkInternetConnection();
                        if (employeProvider.profileImage == null) {
                          getFlushBar(context,
                              title: 'Warning! Image is required');
                        } else if (nameController.text.isEmpty) {
                          getFlushBar(context,
                              title: 'Warning! Team name is required');
                        } else if (!isInternetConnect) {
                          showNoInternetDialog(context);
                        } else {
                          var id =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          String imageurl = await employeProvider
                              .uploadImagetoFirebaseStorage(
                                  employeProvider.profileImage!);

                          // ignore: use_build_context_synchronously
                          employeProvider
                              .addNewTeam(
                                  context: context,
                                  id: id,
                                  imageUrl: imageurl,
                                  teamName: nameController.text.toString())
                              .then((value) {
                            nameController.clear();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigationBarView(
                                          index: 2,
                                        )));
                          });
                        }
                      },
                      bordeRadius: 0,
                    ),
                  ],
                )
              ]),
            ),
          ),
        ));
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
