// ignore_for_file: use_build_context_synchronously

import 'package:event_owner_app/helper/exports.dart';
import 'package:event_owner_app/screens/profile/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<FormState> _profileKey = GlobalKey<FormState>();

  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController restaurantAddressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<String> dropdownItemList = ["Kitchen", "Services", "Both"];
  String? selectedCategory;
  String? selectedReference;

  Future<void> setInitialsData() async {
    final p = Provider.of<ProfileProvider>(context, listen: false);
    var id = FirebaseAuth.instance.currentUser!.uid;
    var fs1 =
        await FirebaseFirestore.instance.collection("owners").doc(id).get();
    var fs2 = await FirebaseFirestore.instance.collection("restaurants").get();
    var data = fs2.docs;
    String ref = "";
    for (var i = 0; i < data.length; i++) {
      if (id == data[i].get("ownerId")) {
        ref = data[i].reference.id;
      }
    }

    var fs3 = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(ref)
        .get();

    selectedCategory = fs3["catergory"];
    setState(() {});
    p.obj.restaurantImage = fs3["image"];
    restaurantAddressController.text = fs3["restaurantAddress"];
    contactController.text = fs3["contact"];
    descriptionController.text = fs3["restaurantDescription"];
    ownerNameController.text = fs1["ownerName"];
    emailController.text = fs1["email"];
    passwordController.text = fs1["password"];
    restaurantNameController.text = fs1["restaurantName"];
    selectedReference = ref;
    setState(() {});
  }

  @override
  void initState() {
    setInitialsData();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    restaurantNameController.dispose();
    ownerNameController.dispose();
    contactController.dispose();
    restaurantAddressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
        fontSize: 20,
        color: ThemeColors.mainColor,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: ThemeColors.grey3,
      borderRadius: BorderRadius.circular(10),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MySize.size70,
                      width: MySize.safeWidth,
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Consumer<ProfileProvider>(
                          builder: (context, p, child) => p
                                  .profileImage.path.isNotEmpty
                              ? Container(
                                  width: MySize.size100,
                                  height: MySize.size100,
                                  decoration: ShapeDecoration(
                                    color: ThemeColors.grey3,
                                    shape: const CircleBorder(),
                                    image: p.profileImage.path.isEmpty
                                        ? const DecorationImage(
                                            image: AssetImage(imgUser),
                                          )
                                        : DecorationImage(
                                            image: FileImage(p.profileImage),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                )
                              : CachedNetworkImage(
                                  height: MySize.size100,
                                  width: MySize.size100,
                                  imageUrl: p.obj.restaurantImage ?? "",
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ThemeColors.grey6),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.image_not_supported_outlined,
                                        color: ThemeColors.mainColor,
                                        size: 40,
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2.0),
                                    );
                                  },
                                ),
                        ),
                        Consumer<ProfileProvider>(
                          builder: (context, p, child) => InkWell(
                            onTap: p.editFlag
                                ? () async {
                                    selectImageBottomSheet(context);
                                  }
                                : () {},
                            child: Container(
                              width: MySize.size25,
                              height: MySize.size25,
                              decoration: const ShapeDecoration(
                                color: ThemeColors.mainColor,
                                shape: CircleBorder(),
                              ),
                              margin: Spacing.horizontal(MySize.size6),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: MySize.size18,
                                color: ThemeColors.bgColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MySize.size25),
                    Consumer<ProfileProvider>(
                      builder: (context, p, child) => Form(
                        key: _profileKey,
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
                                readOnly: !p.editFlag,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(
                                      value);
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
                                readOnly: !p.editFlag,
                                fillColor: ThemeColors.fillColor,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(
                                      value);
                                },
                              ),
                            ),
                            SizedBox(height: MySize.size12),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MySize.size30),
                              child: CustomDropdownButton2(
                                dropdownItems: dropdownItemList,
                                hint: "Select Category",
                                value: selectedCategory,
                                onChanged: p.editFlag
                                    ? (value) {
                                        setState(() {
                                          selectedCategory = value.toString();
                                        });
                                      }
                                    : (value) {},
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
                                dropdownWidth:
                                    (MySize.safeWidth - MySize.size65),
                              ),
                            ),
                            SizedBox(height: MySize.size12),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: CustomTextField13(
                                controller: emailController,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                readOnly: !p.editFlag,
                                hintText: AppLocalizations.of(context)!
                                    .email
                                    .toString(),
                                fillColor: ThemeColors.fillColor,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(
                                      value);
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
                                readOnly: !p.editFlag,
                                hintText: AppLocalizations.of(context)!
                                    .phone
                                    .toString(),
                                fillColor: ThemeColors.fillColor,
                                sufixIcon: Icon(Icons.verified,
                                    color: ThemeColors.mainColor,
                                    size: MySize.size18),
                                onTap: () {
                                  customChangePhoneNumber(context);
                                },
                                validator: (value) {
                                  return CommonFunctions.validateTextField(
                                      value);
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
                                readOnly: !p.editFlag,
                                hintText: AppLocalizations.of(context)!
                                    .location
                                    .toString(),
                                fillColor: ThemeColors.fillColor,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(
                                      value);
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
                                readOnly: !p.editFlag,
                                hintText: AppLocalizations.of(context)!
                                    .description
                                    .toString(),
                                fillColor: ThemeColors.fillColor,
                                maxLines: 5,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(
                                      value);
                                },
                              ),
                            ),
                            SizedBox(height: MySize.size12),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: CustomTextField13(
                                      controller: passwordController,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.text,
                                      hintText: AppLocalizations.of(context)!
                                          .password
                                          .toString(),
                                      readOnly: !p.editFlag,
                                      fillColor: ThemeColors.fillColor,
                                      sufixIcon: p.obsecureText
                                          ? InkWell(
                                              onTap: () {
                                                p.setObsecureText(
                                                    !p.obsecureText);
                                              },
                                              child: const Icon(
                                                Icons.visibility_off_outlined,
                                                color: ThemeColors.mainColor,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                p.setObsecureText(
                                                    !p.obsecureText);
                                              },
                                              child: const Icon(
                                                Icons.visibility_outlined,
                                                color: ThemeColors.mainColor,
                                              ),
                                            ),
                                      obscureText: p.obsecureText,
                                      validator: (value) {
                                        return CommonFunctions
                                            .validateTextField(value);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: MySize.size10),
                                  Container(
                                    width: MySize.size60,
                                    height: MySize.size25,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(MySize.size5),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .reset
                                          .toString(),
                                      style: TextStyle(
                                        color: ThemeColors.mainColor,
                                        fontSize: MySize.size12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MySize.size35),
                  ],
                ),
              ),
            ),
            Container(
              height: MySize.size60,
              color: ThemeColors.bgColor,
              child: Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      return InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child:
                            SvgPicture.asset(icMenu, color: ThemeColors.black1),
                      );
                    }),
                    Text(
                      AppLocalizations.of(context)!.profile.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Consumer<ProfileProvider>(
                      builder: (context, p, child) => InkWell(
                        onTap: !p.editFlag
                            ? () {
                                //edit
                                p.setEditFlag(!p.editFlag);
                              }
                            : () async {
                                //save
                                p.setEditFlag(!p.editFlag);
                                if (_profileKey.currentState!.validate()) {
                                  await p
                                      .updateProfileAndRestaurant(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    restaurantName:
                                        restaurantNameController.text,
                                    ownerName: ownerNameController.text,
                                    category: selectedCategory.toString(),
                                    contact: contactController.text,
                                    address: restaurantAddressController.text,
                                    description: descriptionController.text,
                                    reference: selectedReference!,
                                    context: context,
                                  )
                                      .then((value) {
                                    setInitialsData().then((value) {
                                      setState(() {});
                                    });
                                  });
                                } else {
                                  CommonFunctions.flushBarErrorMessage(
                                    "Field is Required",
                                    context,
                                  );
                                }
                              },
                        child: Text(
                          p.editFlag
                              ? AppLocalizations.of(context)!.save.toString()
                              : AppLocalizations.of(context)!.edit.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    // SvgPicture.asset(icBell, color: ThemeColors.bgColor),
                  ],
                ),
              ),
            ),
          ],
        ),
        Consumer<ProfileProvider>(
          builder: (context, p, child) =>
              p.showLoader ? const LoaderView() : Container(),
        ),
      ],
    );
  }

  selectImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ProfileProvider>(
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
                    Navigator.pop(context);
                    await p.imgFromGallery();
                    await uploadImageToFirebase(p.profileImage.path);
                  },
                ),
                BottomSheetItemRow(
                  title: 'Camera',
                  icon: CupertinoIcons.photo_camera,
                  onTap: () async {
                    Navigator.pop(context);
                    await p.imgFromCamera();
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

  Future<String?> uploadImageToFirebase(String? imagePath) async {
    final obj = Provider.of<ProfileProvider>(context, listen: false);
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

  customChangePhoneNumber(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: MySize.size400,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(MySize.size12, MySize.size11,
                      MySize.size12, MySize.size2),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close,
                            size: MySize.size20, color: ThemeColors.mainColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.verification.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                  padding: Spacing.horizontal(MySize.size22),
                  child: Text(
                    'Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CountryFlagNumberTextField(
                    initialvalue: "+966",
                    title: AppLocalizations.of(context)!
                        .enterPhoneNumber
                        .toString(),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.continuee.toString(),
                    radius: MySize.size30,
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    onPressed: () {
                      Navigator.pop(context);
                      customOTPVerfication(context);
                    },
                  ),
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }

  customOTPVerfication(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: MySize.size400,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(MySize.size12, MySize.size11,
                      MySize.size12, MySize.size2),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close,
                            size: MySize.size20, color: ThemeColors.mainColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.oTP.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                    padding: Spacing.horizontal(MySize.size22),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum,',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '\n+966 21753713',
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Column(
                    children: [
                      Pinput(
                        length: 4,
                        defaultPinTheme: defaultPinTheme,
                        validator: (s) {
                          return s == '2222' ? null : 'Pin is incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => print(pin),
                      ),
                      SizedBox(height: MySize.size25),
                      Text(
                        AppLocalizations.of(context)!
                            .didntReceivedOTP
                            .toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.verify.toString(),
                    radius: MySize.size30,
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }
}
