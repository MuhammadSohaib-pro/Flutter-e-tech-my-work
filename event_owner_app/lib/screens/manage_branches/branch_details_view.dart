// ignore_for_file: deprecated_member_use

import 'package:event_owner_app/helper/exports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BranchDetailsView extends StatefulWidget {
  const BranchDetailsView(
      {super.key,
      required this.branchRef,
      required this.managerDocId,
      required this.restaurantRef});
  final String branchRef;
  final String restaurantRef;
  final String managerDocId;

  @override
  State<BranchDetailsView> createState() => _BranchDetailsViewState();
}

class _BranchDetailsViewState extends State<BranchDetailsView> {
  String? branchStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context)!.branchDetails.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              manageBranchDetailsBottomSheet(context);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: ThemeColors.grey1,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MySize.size40),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("restaurants")
                      .doc(widget.restaurantRef)
                      .collection("branches")
                      .doc(widget.branchRef)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.data() != null) {
                        branchStatus = snapshot.data!
                            .data()!["activeOrDeactive"]
                            .toString();
                      }
                      return snapshot.data!.data() != null
                          ? Column(
                              children: [
                                CachedNetworkImage(
                                  height: MySize.size90,
                                  width: MySize.size90,
                                  imageUrl: snapshot.data!
                                      .data()!["image"]
                                      .toString(),
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
                                ),
                                SizedBox(height: MySize.size10),
                                Text(
                                  snapshot.data!.data()!["name"] ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  branchStatus == "Active"
                                      ? AppLocalizations.of(context)!
                                          .active
                                          .toString()
                                      : AppLocalizations.of(context)!
                                          .deactive
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: branchStatus == "Active"
                                        ? ThemeColors.mainColor
                                        : ThemeColors.grey1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size50),
                child: Text(
                  AppLocalizations.of(context)!.branchDetailsDescrp.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size10),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("restaurants")
                    .doc(widget.restaurantRef)
                    .collection("managers")
                    .doc(widget.managerDocId)
                    // .where("deleteStatus",isEqualTo: "notDeleted")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.data() != null &&
                            snapshot.data!.data()!["deleteStatus"].toString() ==
                                "notDeleted"
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    height: MySize.size50,
                                    width: MySize.size50,
                                    imageUrl: snapshot.data!
                                        .data()!["image"]
                                        .toString(),
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
                                  ),
                                  SizedBox(width: MySize.size8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .manager
                                            .toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF999999),
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!
                                            .data()!["managerName"]
                                            .toString(),
                                        style: TextStyle(
                                          color: ThemeColors.black1,
                                          fontSize: MySize.size14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: MySize.size15),
                            ],
                          )
                        : Text(
                            'Sorry, In this Branch you do not selected any Manager ',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: MySize.size30,
                        decoration: ShapeDecoration(
                          color: ThemeColors.fillColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '5.0',
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: MySize.size5),
                            Icon(
                              Icons.star_rate_rounded,
                              color: ThemeColors.yellow,
                              size: MySize.size16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    Expanded(
                      child: Container(
                        height: MySize.size30,
                        decoration: ShapeDecoration(
                          color: ThemeColors.fillColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .availablenow
                                  .toString(),
                              style: TextStyle(
                                color: const Color(0xFF47AF08),
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: MySize.size5),
                            SvgPicture.asset(
                              icCountdown,
                              color: const Color(0xFF47AF08),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size10),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("restaurants")
                      .doc(widget.restaurantRef)
                      .collection("branches")
                      .doc(widget.branchRef)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.data() != null
                          ? Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Container(
                                width: double.infinity,
                                height: MySize.size30,
                                decoration: ShapeDecoration(
                                  color: ThemeColors.fillColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                padding: Spacing.horizontal(MySize.size10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: ThemeColors.mainColor,
                                      size: MySize.size16,
                                    ),
                                    SizedBox(width: MySize.size5),
                                    Expanded(
                                      child: Text(
                                        snapshot.data!
                                            .data()!["address"]
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: ThemeColors.mainColor,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.details.toString(),
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BranchOrdersView(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: MySize.size180,
                    decoration: ShapeDecoration(
                      color: ThemeColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MySize.size10),
                      ),
                      image: const DecorationImage(
                          image: AssetImage(imgHomeBg), fit: BoxFit.cover),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 4,
                          offset: Offset(4, 4),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 20,
                          offset: Offset(-4, -4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          icFileFilled,
                          color: ThemeColors.bgColor,
                        ),
                        Text(
                          AppLocalizations.of(context)!.orderDetails.toString(),
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .activeOrders
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n100',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(width: MySize.size35),
                            Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .completed
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n100',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(width: MySize.size35),
                            Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .totalBranches
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n10',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BranchWalletView(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: MySize.size180,
                    decoration: ShapeDecoration(
                      color: ThemeColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MySize.size10),
                      ),
                      image: const DecorationImage(
                        image: AssetImage(imgHomeBg),
                        fit: BoxFit.cover,
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 4,
                          offset: Offset(4, 4),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 20,
                          offset: Offset(-4, -4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          icWalletFilled,
                          color: ThemeColors.bgColor,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .earningDetails
                              .toString(),
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .walletBalance
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n\$ 10,000.00',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(width: MySize.size35),
                            Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .thisMonthEarning
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n5,000.00',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MySize.size16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MySize.size30),
            ],
          ),
        ),
      ),
    );
  }

  manageBranchDetailsBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MySize.size30),
          topRight: Radius.circular(MySize.size30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: InkWell(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MySize.size30),
                    topRight: Radius.circular(MySize.size30),
                  ),
                ),
                child: Consumer<AddEditBranchProvider>(
                  builder: (context, p, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: MySize.size20),
                      TextButton(
                        onPressed: () {
                          p.activeDeactiveBranch(
                            ref: widget.branchRef,
                            addRef: widget.restaurantRef,
                            activeDeactive: branchStatus == "Active"
                                ? "Deactive"
                                : "Active",
                            context: context,
                          );
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          branchStatus == "Active"
                              ? AppLocalizations.of(context)!
                                  .deactive
                                  .toString()
                              : AppLocalizations.of(context)!.active.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.size10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditBranchView(
                                  type: "Edit",
                                  branchRef: widget.branchRef,
                                  restaurantRef: widget.restaurantRef),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.edit.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.size10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          customResetPassword(context);
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .resetPassword
                              .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.size10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          customDeleteDialog(context: context);
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.delete.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.size10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.cancel.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.size20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  customResetPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: MySize.size420,
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
                  AppLocalizations.of(context)!.changePassword.toString(),
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
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    hintText:
                        AppLocalizations.of(context)!.newPassword.toString(),
                    title: AppLocalizations.of(context)!.newPassword.toString(),
                    fillColor: ThemeColors.fillColor,
                    validator: (value) {
                      return CommonFunctions.validateTextField(value);
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    hintText: AppLocalizations.of(context)!
                        .confirmPassword
                        .toString(),
                    title: AppLocalizations.of(context)!
                        .confirmPassword
                        .toString(),
                    fillColor: ThemeColors.fillColor,
                    validator: (value) {
                      return CommonFunctions.validateTextField(value);
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.save.toString(),
                    radius: MySize.size30,
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    onPressed: () {
                      Navigator.pop(context);
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

  customDeleteDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size30),
          ),
          child: Container(
            height: MySize.size213,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size30),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x2B000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(
                      MySize.size20, MySize.size15, MySize.size20, 0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: MySize.size20,
                          color: ThemeColors.black1,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.warning_amber_rounded,
                  size: MySize.size42,
                  color: ThemeColors.mainColor,
                ),
                SizedBox(height: MySize.size8),
                Text(
                  AppLocalizations.of(context)!.warning.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MySize.size10),
                Text(
                  AppLocalizations.of(context)!.warningdescrp.toString(),
                  style: TextStyle(
                    color: const Color(0xFF7D7D7D),
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Consumer<AddEditBranchProvider>(
                  builder: (context, p, child) => SizedBox(
                    width: MySize.size117,
                    height: MySize.size36,
                    child: CustomButton8(
                      text: AppLocalizations.of(context)!.delete.toString(),
                      radius: MySize.size30,
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      onPressed: () async {
                        p.deleteBranch(
                            ref: widget.branchRef,
                            addRef: widget.restaurantRef,
                            context: context);
                      },
                    ),
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
