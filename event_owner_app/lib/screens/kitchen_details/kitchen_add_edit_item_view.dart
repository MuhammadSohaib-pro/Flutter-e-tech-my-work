// ignore_for_file: use_build_context_synchronously

import 'package:event_owner_app/helper/exports.dart';
import 'package:event_owner_app/model/item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class KitchenAddEditItemView extends StatefulWidget {
  const KitchenAddEditItemView(
      {super.key, required this.process, required this.itemReference});
  final String itemReference;
  final String process;

  @override
  State<KitchenAddEditItemView> createState() => _KitchenAddEditItemViewState();
}

class _KitchenAddEditItemViewState extends State<KitchenAddEditItemView> {
  final GlobalKey<FormState> _addItems = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  List<String> referenceList = [];
  String? selectedCategoryRef;
  List<String> dropdownItemList = [];

  setDropDownList() async {
    String ref = "";
    var fs2 = await FirebaseFirestore.instance.collection("restaurants").get();
    var data = fs2.docs;
    for (var i = 0; i < data.length; i++) {
      if (FirebaseAuth.instance.currentUser!.uid == data[i].get("ownerId")) {
        ref = data[i].reference.id;
      }
    }
    var firestore = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(ref)
        .collection("kitchens")
        .get();
    dropdownItemList.addAll(
      firestore.docs.map(
        (e) => e.get("categoryName").toString(),
      ),
    );
    referenceList.addAll(firestore.docs.map((e) => e.reference.id));
    setState(() {});
  }

  setInitialsData() async {
    String ref = "";
    var fs2 = await FirebaseFirestore.instance.collection("restaurants").get();
    var data1 = fs2.docs;
    for (var i = 0; i < data1.length; i++) {
      if (FirebaseAuth.instance.currentUser!.uid == data1[i].get("ownerId")) {
        ref = data1[i].reference.id;
      }
    }
    final p = Provider.of<AddEditKitchenProvider>(context, listen: false);
    var firestore = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(ref)
        .collection("items")
        .doc(widget.itemReference)
        .get();

    p.obj = ItemModel.fromJson(firestore.data() as Map<String, dynamic>);
    nameController.text = p.obj.itemName ?? "";
    priceController.text = "${p.obj.itemPrice ?? 0}";
    descriptionController.text = p.obj.itemDescription ?? "";
    setState(() {});

    if (firestore.data() != null) {
      selectedCategoryRef = p.obj.selectedCategoryDoc ?? "";
      var dt = await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(ref)
          .collection("kitchens")
          .doc(selectedCategoryRef)
          .get();
      selectedCategory = dt.get("categoryName").toString();
    }
    setState(() {});
  }

  @override
  void initState() {
    if (widget.process != "Add") {
      setInitialsData();
    }
    setDropDownList();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.bgColor,
            title: Text(
              widget.process == "Add"
                  ? AppLocalizations.of(context)!.addItems.toString()
                  : AppLocalizations.of(context)!.editItems.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MySize.size20),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: Consumer<AddEditKitchenProvider>(
                      builder: (context, p, child) => widget.process == "Add"
                          ? Container(
                              width: double.infinity,
                              height: MySize.size173,
                              decoration: ShapeDecoration(
                                color: ThemeColors.grey3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                image: p.profileImage.path.isEmpty
                                    ? const DecorationImage(
                                        image: AssetImage(imgPic),
                                      )
                                    : DecorationImage(
                                        image: FileImage(p.profileImage),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            )
                          : p.obj.itemImage != null
                              ? CachedNetworkImage(
                                  width: double.infinity,
                                  height: MySize.size173,
                                  imageUrl: p.obj.itemImage!,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      width: double.infinity,
                                      height: MySize.size173,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
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
                                  height: MySize.size100,
                                  width: MySize.size100),
                    ),
                  ),
                  widget.process == "Add"
                      ? TextButton(
                          onPressed: () {
                            selectImageBottomSheet(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .uploadImage
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: MySize.size40),
                  Form(
                    key: _addItems,
                    child: Column(
                      children: [
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: nameController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText:
                                AppLocalizations.of(context)!.title.toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size10),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: priceController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            hintText:
                                AppLocalizations.of(context)!.price.toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size10),
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
                                for (var i = 0;
                                    i < dropdownItemList.length;
                                    i++) {
                                  if (dropdownItemList[i] == selectedCategory) {
                                    selectedCategoryRef = referenceList[i];
                                  }
                                }
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
                        // SizedBox(height: MySize.size10),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: MySize.size32),
                        //   child: Container(
                        //     width: double.infinity,
                        //     height: MySize.size50,
                        //     decoration: ShapeDecoration(
                        //       color: ThemeColors.fillColor,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(MySize.size10),
                        //       ),
                        //     ),
                        //     alignment: Alignment.center,
                        //     padding: EdgeInsets.symmetric(horizontal: MySize.size20),
                        //     child: DropdownMenu<String>(
                        //       width: MySize.screenWidth / 1.3,
                        //       hintText: AppLocalizations.of(context)!
                        //           .selectBranch
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
                        //         DropdownMenuEntry(value: "All", label: "All"),
                        //         DropdownMenuEntry(
                        //             value: "Saudi Arabia, Riyadh",
                        //             label: "Saudi Arabia, Riyadh"),
                        //         DropdownMenuEntry(
                        //             value: "Saudi Arabia, Al-Kharaj",
                        //             label: "Saudi Arabia, Al-Kharaj")
                        //       ],
                        //       onSelected: (value) {
                        //         print(value);
                        //       },
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: MySize.size10),
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
                  SizedBox(height: MySize.size20),
                  Consumer<AddEditKitchenProvider>(
                    builder: (context, p, child) => Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: CustomButton8(
                        text: widget.process == "Add"
                            ? AppLocalizations.of(context)!.add.toString()
                            : AppLocalizations.of(context)!.save.toString(),
                        radius: MySize.size30,
                        backgroundColor: ThemeColors.mainColor,
                        textColor: ThemeColors.bgColor,
                        onPressed: widget.process == "Add"
                            ? () {
                                if (_addItems.currentState!.validate()) {
                                  if (p.imageLink.isNotEmpty ||
                                      p.profileImage.path.isNotEmpty) {
                                    p.addNewItems(
                                        itemName: nameController.text,
                                        itemPrice: double.parse(
                                            priceController.text.toString()),
                                        itemDescription:
                                            descriptionController.text,
                                        selectedCategoryDoc:
                                            selectedCategoryRef!,
                                        context: context);
                                  } else {
                                    CommonFunctions.flushBarErrorMessage(
                                        "Please Select Image First", context);
                                  }
                                }
                              }
                            : () {
                                if (_addItems.currentState!.validate()) {
                                  p.editItems(
                                      itemName: nameController.text,
                                      itemReference: widget.itemReference,
                                      itemPrice: double.parse(
                                          priceController.text.toString()),
                                      itemDescription:
                                          descriptionController.text,
                                      selectedCategoryDoc: selectedCategoryRef!,
                                      context: context);
                                }
                              },
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size60),
                ],
              ),
            ),
          ),
        ),
        Consumer<AddEditKitchenProvider>(
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
        return Consumer<AddEditKitchenProvider>(
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
    final obj = Provider.of<AddEditKitchenProvider>(context, listen: false);
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
}
