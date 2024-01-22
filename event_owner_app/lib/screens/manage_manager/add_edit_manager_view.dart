// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:event_owner_app/helper/exports.dart';
import 'package:flutter/cupertino.dart';

class AddEditManagerView extends StatefulWidget {
  const AddEditManagerView(
      {super.key,
      required this.type,
      required this.managerRef,
      required this.restaurantRef});
  final String type;
  final String managerRef;
  final String restaurantRef;
  @override
  State<AddEditManagerView> createState() => _AddEditManagerViewState();
}

class _AddEditManagerViewState extends State<AddEditManagerView> {
  final GlobalKey<FormState> _addManager = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController managerNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  setInitialsData() async {
    final p = Provider.of<AddEditManagerProvider>(context, listen: false);
    // p.obj = ManagerModel();
    var data = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(widget.restaurantRef)
        .collection("managers")
        .doc(widget.managerRef)
        .get();
    p.obj = ManagerModel.fromJson(data.data() as Map<String, dynamic>);
    managerNameController.text = p.obj.managerName.toString();
    emailController.text = p.obj.mangerEmail.toString();
    addressController.text = p.obj.address.toString();
    phoneController.text = p.obj.contact.toString();
    setState(() {});
  }

  @override
  void initState() {
    if (widget.type != "add") {
      setInitialsData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.bgColor,
            elevation: 0.0,
            title: Text(
              widget.type == "add"
                  ? AppLocalizations.of(context)!.addManager.toString()
                  : AppLocalizations.of(context)!.editManager.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ScrollableColumn(
              children: [
                SizedBox(height: MySize.size50),
                Consumer<AddEditManagerProvider>(
                  builder: (context, p, child) => widget.type == "add"
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
                      : p.obj.image != null
                          ? CachedNetworkImage(
                              height: MySize.size100,
                              width: MySize.size100,
                              imageUrl: p.obj.image!,
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
                                  ),
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
                            )
                          : SizedBox(
                              height: MySize.size100, width: MySize.size100),
                ),
                // SizedBox(height: MySize.size10),
                widget.type == "add"
                    ? TextButton(
                        onPressed: () {
                          selectImageBottomSheet(context);
                        },
                        child: Text(
                          widget.type == "add"
                              ? AppLocalizations.of(context)!
                                  .uploadImage
                                  .toString()
                              : AppLocalizations.of(context)!
                                  .taptoEdit
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(height: MySize.size30),
                Form(
                  key: _addManager,
                  child: Column(
                    children: [
                      Padding(
                        padding: Spacing.horizontal(MySize.size32),
                        child: CustomTextField13(
                          controller: managerNameController,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          hintText: AppLocalizations.of(context)!
                              .managerName
                              .toString(),
                          title: AppLocalizations.of(context)!
                              .managerName
                              .toString(),
                          fillColor: ThemeColors.fillColor,
                          validator: (value) {
                            return CommonFunctions.validateTextField(value);
                          },
                        ),
                      ),
                      SizedBox(height: MySize.size15),
                      Padding(
                        padding: Spacing.horizontal(MySize.size32),
                        child: CustomTextField13(
                          controller: emailController,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          hintText: AppLocalizations.of(context)!
                              .enterEmail
                              .toString(),
                          title: AppLocalizations.of(context)!.email.toString(),
                          fillColor: ThemeColors.fillColor,
                          validator: (value) {
                            return CommonFunctions.validateTextField(value);
                          },
                        ),
                      ),
                      SizedBox(height: MySize.size15),
                      Padding(
                        padding: Spacing.horizontal(MySize.size32),
                        child: CustomTextField13(
                          controller: phoneController,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          hintText:
                              AppLocalizations.of(context)!.contact.toString(),
                          title:
                              AppLocalizations.of(context)!.contact.toString(),
                          fillColor: ThemeColors.fillColor,
                          validator: (value) {
                            return CommonFunctions.validateTextField(value);
                          },
                        ),
                      ),
                      SizedBox(height: MySize.size15),
                      Padding(
                        padding: Spacing.horizontal(MySize.size32),
                        child: CustomTextField13(
                          controller: addressController,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          hintText:
                              AppLocalizations.of(context)!.address.toString(),
                          title:
                              AppLocalizations.of(context)!.address.toString(),
                          fillColor: ThemeColors.fillColor,
                          validator: (value) {
                            return CommonFunctions.validateTextField(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MySize.size15),
                const Spacer(),
                Consumer<AddEditManagerProvider>(
                  builder: (context, p, child) => Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: CustomButton8(
                      text: widget.type == "add"
                          ? AppLocalizations.of(context)!.add.toString()
                          : AppLocalizations.of(context)!.save.toString(),
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      radius: MySize.size30,
                      onPressed: widget.type == "add"
                          ? () {
                              if (_addManager.currentState!.validate()) {
                                if (p.imageLink.isNotEmpty ||
                                    p.profileImage.path.isNotEmpty) {
                                  p
                                      .addNewManager(
                                    managerName: managerNameController.text,
                                    email: emailController.text,
                                    address: addressController.text,
                                    phone: phoneController.text,
                                    context: context,
                                  )
                                      .then((value) {
                                    clearTextFormFields();
                                  });
                                } else {
                                  CommonFunctions.flushBarErrorMessage(
                                    "Select Image First",
                                    context,
                                  );
                                }
                              } else {
                                CommonFunctions.flushBarErrorMessage(
                                  "Field is Required",
                                  context,
                                );
                              }
                            }
                          : () {
                              if (_addManager.currentState!.validate()) {
                                p
                                    .editNewManager(
                                  managerName: managerNameController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  phone: phoneController.text,
                                  reference: widget.managerRef,
                                  context: context,
                                )
                                    .then((value) {
                                  clearTextFormFields();
                                });
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
                SizedBox(height: MySize.size40),
              ],
            ),
          ),
        ),
        Consumer<AddEditManagerProvider>(
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
        return Consumer<AddEditManagerProvider>(
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
    final obj = Provider.of<AddEditManagerProvider>(context, listen: false);
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

  clearTextFormFields() {
    emailController.clear();
    managerNameController.clear();
    addressController.clear();
  }
}
