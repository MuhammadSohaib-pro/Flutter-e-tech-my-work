// ignore_for_file: use_build_context_synchronously

import 'package:event_owner_app/helper/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddEditBranchView extends StatefulWidget {
  const AddEditBranchView(
      {super.key,
      required this.type,
      required this.branchRef,
      required this.restaurantRef});

  final String type;
  final String branchRef;
  final String restaurantRef;

  @override
  State<AddEditBranchView> createState() => _AddEditBranchViewState();
}

class _AddEditBranchViewState extends State<AddEditBranchView> {
  final GlobalKey<FormState> _addBranch = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<String> dropdownItemList = [];
  List<String> referenceList = [];
  String? selectedManager;
  String? selectedRef;

  getAllManager() async {
    String ref = "";
    var fs2 = await FirebaseFirestore.instance.collection("restaurants").get();
    var data1 = fs2.docs;
    for (var i = 0; i < data1.length; i++) {
      if (FirebaseAuth.instance.currentUser!.uid == data1[i].get("ownerId")) {
        ref = data1[i].reference.id;
      }
    }
    var firestore = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(ref)
        .collection("managers")
        .where("deleteStatus",isEqualTo: "notDeleted")
        .get();
    dropdownItemList.addAll(
      firestore.docs.map(
        (e) => ManagerModel.fromJson(e.data()).managerName.toString(),
      ),
    );
    referenceList.addAll(firestore.docs.map((e) => e.reference.id));
    final p = Provider.of<AddEditBranchProvider>(context, listen: false);
    var data = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(widget.restaurantRef)
        .get();
    p.setImageLink(data["image"]);
    setState(() {});
  }

  setInitialsData() async {
    final p = Provider.of<AddEditBranchProvider>(context, listen: false);
    var data = await FirebaseFirestore.instance
        .collection("restaurants")
        .doc(widget.restaurantRef)
        .collection("branches")
        .doc(widget.branchRef)
        .get();
    p.obj = BranchModel.fromJson(data.data() as Map<String, dynamic>);
    emailController.text = p.obj.email ?? "";
    nameController.text = p.obj.name ?? "";
    passwordController.text = p.obj.password ?? "";
    addressController.text = p.obj.address ?? "";
    phoneController.text = p.obj.contact ?? "";
    var newData = await FirebaseFirestore.instance
        .collection("managers")
        .doc(p.obj.managerDocId)
        .get();
    if (newData.data() != null) {
      selectedManager = p.obj.managerName ?? "";
      selectedRef = p.obj.managerDocId ?? "";
    }
    setState(() {});
  }

  @override
  void initState() {
    getAllManager();
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
                  ? AppLocalizations.of(context)!.addBranch.toString()
                  : AppLocalizations.of(context)!.editBranch.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: ScrollableColumn(
              children: [
                SizedBox(height: MySize.size20),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.selectManager.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MySize.size5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MySize.size30),
                  child: CustomDropdownButton2(
                    dropdownItems: dropdownItemList,
                    hint: "Select Branch Manager",
                    value: selectedManager,
                    onChanged: (value) {
                      setState(() {
                        selectedManager = value.toString();
                        for (var i = 0; i < dropdownItemList.length; i++) {
                          if (dropdownItemList[i] == selectedManager) {
                            selectedRef = referenceList[i];
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
                SizedBox(height: MySize.size12),
                Consumer<AddEditBranchProvider>(
                  builder: (context, p, child) => widget.type != "add"
                      ? (p.obj.managerName == null || p.obj.managerName == null)
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MySize.size30),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Please select a new branch manager',
                                        style: TextStyle(
                                            color: ThemeColors.red,
                                            fontSize: MySize.size12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: MySize.size12),
                              ],
                            )
                          : const SizedBox()
                      : const SizedBox(),
                ),
                Consumer<AddEditBranchProvider>(
                  builder: (context, p, child) => Form(
                    key: _addBranch,
                    child: Column(
                      children: [
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: nameController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: "Name",
                            title: "Name",
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
                            controller: addressController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .branchLocation
                                .toString(),
                            title: AppLocalizations.of(context)!
                                .branchLocation
                                .toString(),
                            prefixIcon: Icon(
                              Icons.location_on_rounded,
                              color: ThemeColors.mainColor,
                              size: MySize.size18,
                            ),
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
                            controller: emailController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .enterEmail
                                .toString(),
                            title:
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
                            controller: phoneController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            hintText: AppLocalizations.of(context)!
                                .contact
                                .toString(),
                            title: AppLocalizations.of(context)!
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
                            hintText: widget.type == "add"
                                ? AppLocalizations.of(context)!
                                    .createPassword
                                    .toString()
                                : AppLocalizations.of(context)!
                                    .password
                                    .toString(),
                            title: widget.type == "add"
                                ? AppLocalizations.of(context)!
                                    .createPassword
                                    .toString()
                                : AppLocalizations.of(context)!
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
                        widget.type == "add"
                            ? SizedBox(height: MySize.size12)
                            : const SizedBox(),
                        widget.type == "add"
                            ? Padding(
                                padding: Spacing.horizontal(MySize.size32),
                                child: CustomTextField13(
                                  controller: confirmPasswordController,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.text,
                                  hintText: AppLocalizations.of(context)!
                                      .confirmPassword
                                      .toString(),
                                  title: AppLocalizations.of(context)!
                                      .confirmPassword
                                      .toString(),
                                  fillColor: ThemeColors.fillColor,
                                  sufixIcon: p.obsecureText2
                                      ? InkWell(
                                          onTap: () {
                                            p.setObsecureText2(
                                                !p.obsecureText2);
                                          },
                                          child: const Icon(
                                            Icons.visibility_off_outlined,
                                            color: ThemeColors.mainColor,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            p.setObsecureText2(
                                                !p.obsecureText2);
                                          },
                                          child: const Icon(
                                            Icons.visibility_outlined,
                                            color: ThemeColors.mainColor,
                                          ),
                                        ),
                                  obscureText: p.obsecureText2,
                                  validator: (value) {
                                    return CommonFunctions.validateTextField(
                                        value);
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MySize.size20),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Consumer<AddEditBranchProvider>(
                    builder: (context, p, child) => CustomButton8(
                      text: widget.type == "add"
                          ? AppLocalizations.of(context)!.submit.toString()
                          : AppLocalizations.of(context)!.save.toString(),
                      radius: MySize.size30,
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      onPressed: widget.type == "add"
                          ? () {
                              if (_addBranch.currentState!.validate()) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  p
                                      .addNewBranch(
                                    managerName: selectedManager!,
                                    email: emailController.text,
                                    address: addressController.text,
                                    phone: phoneController.text,
                                    managerRefId: selectedRef!,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    ref: widget.restaurantRef,
                                    context: context,
                                  )
                                      .then((value) {
                                    clearTextFormFields();
                                  });
                                } else {
                                  CommonFunctions.flushBarErrorMessage(
                                    "Password didnot match",
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
                              if (_addBranch.currentState!.validate()) {
                                p
                                    .editNewBranch(
                                  managerName: selectedManager!,
                                  email: emailController.text,
                                  address: addressController.text,
                                  phone: phoneController.text,
                                  managerRefId: selectedRef!,
                                  name: nameController.text,
                                  password: passwordController.text,
                                  ref: widget.branchRef,
                                  addRef: widget.restaurantRef,
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
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        ),
        Consumer<AddEditBranchProvider>(
          builder: (context, p, child) =>
              p.showLoader ? const LoaderView() : Container(),
        ),
      ],
    );
  }

  clearTextFormFields() {
    emailController.clear();
    confirmPasswordController.clear();
    passwordController.clear();
    phoneController.clear();
    addressController.clear();
  }
}
