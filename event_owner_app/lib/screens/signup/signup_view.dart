// ignore_for_file: use_build_context_synchronously

import 'package:event_owner_app/helper/exports.dart';
import 'package:flutter/cupertino.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController restaurantAddressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> dropdownItemList = ["Kitchen", "Services", "Both"];
  String? selectedCategory;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    restaurantNameController.dispose();
    ownerNameController.dispose();
    contactController.dispose();
    restaurantAddressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ThemeColors.bgColor,
            title: Text(
              AppLocalizations.of(context)!.register.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.signin.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ThemeColors.mainColor,
                      fontSize: MySize.size12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: ScrollableColumn(
              children: [
                SizedBox(height: MySize.size20),
                Consumer<SignUpProvider>(
                  builder: (context, p, child) => Container(
                    width: MySize.size100,
                    height: MySize.size100,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      shape: const CircleBorder(),
                      image: p.profileImage.path.isEmpty
                          ? const DecorationImage(
                              image: AssetImage(imgStoreFront),
                            )
                          : DecorationImage(
                              image: FileImage(p.profileImage),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    selectImageBottomSheet(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.uploadImage.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: MySize.size20),
                Consumer<SignUpProvider>(
                  builder: (context, p, child) => Form(
                    key: _signUpKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: restaurantNameController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .restaurantName
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: ownerNameController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .ownerName
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: MySize.size30),
                          child: CustomDropdownButton2(
                            dropdownItems: dropdownItemList,
                            hint: "Select Category",
                            value: selectedCategory,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value.toString();
                              });
                            },
                            buttonWidth: double.infinity,
                            buttonHeight: 50,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: ThemeColors.black1,
                              size: MySize.size24,
                            ),
                            buttonDecoration: BoxDecoration(
                              border: Border.all(style: BorderStyle.none),
                              color: ThemeColors.fillColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            dropdownWidth: (MySize.safeWidth - MySize.size65),
                          ),
                        ),
                        SizedBox(height: MySize.size8),

                        // Padding(
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: MySize.size32),
                        //   child: Container(
                        //     width: double.infinity,
                        //     height: MySize.size50,
                        //     decoration: ShapeDecoration(
                        //       color: ThemeColors.fillColor,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius:
                        //             BorderRadius.circular(MySize.size10),
                        //       ),
                        //     ),
                        //     alignment: Alignment.center,
                        //     padding:
                        //         EdgeInsets.symmetric(horizontal: MySize.size20),
                        //     child: DropdownMenu<String>(
                        //       width: MySize.screenWidth / 1.3,
                        //       hintText: AppLocalizations.of(context)!
                        //           .selectCategory
                        //           .toString(),
                        //       textStyle: TextStyle(
                        //         color: ThemeColors.black1,
                        //         fontSize: MySize.size14,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //       trailingIcon: Icon(
                        //         Icons.keyboard_arrow_down_rounded,
                        //         color: ThemeColors.black1,
                        //         size: MySize.size24,
                        //       ),
                        //       inputDecorationTheme: InputDecorationTheme(
                        //         border: InputBorder.none,
                        //         contentPadding: const EdgeInsets.all(0),
                        //         hintStyle: TextStyle(
                        //           color: ThemeColors.black1,
                        //           fontSize: MySize.size12,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //       dropdownMenuEntries: const [
                        //         DropdownMenuEntry(
                        //             value: "Kitchen", label: "Kitchen"),
                        //         DropdownMenuEntry(
                        //             value: "Services", label: "Services"),
                        //         DropdownMenuEntry(value: "Both", label: "Both")
                        //       ],
                        //       onSelected: (value) {
                        //         print(value);
                        //         p.selectCategory(value ?? "");
                        //       },
                        //     ),
                        //   ),
                        // ),

                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: emailController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText:
                                AppLocalizations.of(context)!.email.toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: contactController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .contact
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: passwordController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .password
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            sufixIcon: p.obsecureText1
                                ? InkWell(
                                    onTap: () {
                                      p.setObsecureText1(!p.obsecureText1);
                                    },
                                    child: const Icon(
                                      Icons.visibility_off_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      p.setObsecureText1(!p.obsecureText1);
                                    },
                                    child: const Icon(
                                      Icons.visibility_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  ),
                            obscureText: p.obsecureText1,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: confirmPasswordController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .confirmPassword
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            sufixIcon: p.obsecureText2
                                ? InkWell(
                                    onTap: () {
                                      p.setObsecureText2(!p.obsecureText2);
                                    },
                                    child: const Icon(
                                      Icons.visibility_off_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      p.setObsecureText2(!p.obsecureText2);
                                    },
                                    child: const Icon(
                                      Icons.visibility_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  ),
                            obscureText: p.obsecureText2,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: restaurantAddressController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .restaurantAddress
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: descriptionController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .description
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            maxLines: 5,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MySize.size8),
                SizedBox(height: MySize.size12),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Consumer<SignUpProvider>(
                    builder: (context, p, child) => CustomButton8(
                      text: AppLocalizations.of(context)!.submit.toString(),
                      radius: MySize.size30,
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      onPressed: () async {
                        if (_signUpKey.currentState!.validate()) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            await p.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              restaurantName: restaurantNameController.text,
                              ownerName: ownerNameController.text,
                              category: selectedCategory.toString(),
                              contact: contactController.text,
                              address: restaurantAddressController.text,
                              description: descriptionController.text,
                              context: context,
                            );
                          } else {
                            CommonFunctions.flushBarErrorMessage(
                                "Password Didnot Match", context);
                          }
                        } else {
                          CommonFunctions.flushBarErrorMessage(
                            "Field is Required",
                            context,
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        ),
        Consumer<SignUpProvider>(
          builder: (context, p, child) =>
              p.showLoader ? const LoaderView() : Container(),
        ),
      ],
    );
  }

  Future<String?> uploadImageToFirebase(String? imagePath) async {
    final obj = Provider.of<SignUpProvider>(context, listen: false);
    try {
      obj.changeShowLoaderValue(true);
      if (imagePath != null) {
        final Reference storageRef = FirebaseStorage.instance.ref().child(
            'images/${DateTime.now().millisecondsSinceEpoch.toString()}');
        final UploadTask uploadTask = storageRef.putFile(File(imagePath));
        await uploadTask.whenComplete(() {});
        final String imageURL = await storageRef.getDownloadURL();
        obj.setImageLink(imageURL);
        obj.changeShowLoaderValue(false);
        return imageURL;
      }
      return null;
    } catch (e) {
      obj.changeShowLoaderValue(false);
      print('Error uploading profile image: $e');
      return null;
    }
  }

  selectImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Consumer<SignUpProvider>(
          builder: (context, p, child) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Image',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5.5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.5,
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 14.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                BottomSheetItemRow(
                  title: 'Photo Library',
                  icon: CupertinoIcons.photo_on_rectangle,
                  onTap: () async {
                    await p.imgFromGallery();
                    Navigator.of(context).pop();
                    await uploadImageToFirebase(p.profileImage.path);
                  },
                ),
                BottomSheetItemRow(
                  title: 'Camera',
                  icon: CupertinoIcons.photo_camera,
                  onTap: () async {
                    await p.imgFromCamera();
                    Navigator.of(context).pop();
                    await uploadImageToFirebase(p.profileImage.path);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
