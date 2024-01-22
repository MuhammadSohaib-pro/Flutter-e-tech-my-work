import 'package:event_owner_app/helper/exports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagerDetailsView extends StatefulWidget {
  const ManagerDetailsView(
      {super.key,
      required this.managerRef,
      required this.restaurantRef,
      required this.restaurantImage});
  final String restaurantImage;
  final String managerRef;
  final String restaurantRef;

  @override
  State<ManagerDetailsView> createState() => _ManagerDetailsViewState();
}

class _ManagerDetailsViewState extends State<ManagerDetailsView> {
  String? managerStatus;
  String? deleteStatuss;
  List<BranchModel> branchList = [];

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
              AppLocalizations.of(context)!.managerDetails.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  manageDetailsBottomSheet(context: context);
                },
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: ThemeColors.grey1,
                ),
                splashRadius: 2,
              ),
            ],
          ),
          body: SafeArea(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("restaurants")
                  .doc(widget.restaurantRef)
                  .collection('managers')
                  .doc(widget.managerRef)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data1;
                  if (snapshot.data!.data() != null) {
                    managerStatus =
                        snapshot.data!.data()!["activeOrDeactive"].toString();
                    deleteStatuss =
                        snapshot.data!.data()!["deleteStatus"].toString();
                    data1 = snapshot.data!.data()!;
                  }
                  return snapshot.data!.data() != null
                      ? ScrollableColumn(
                          children: [
                            SizedBox(height: MySize.size50),
                            CachedNetworkImage(
                              height: MySize.size100,
                              width: MySize.size100,
                              imageUrl: data1["image"].toString(),
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
                            SizedBox(height: MySize.size3),
                            Text(
                              managerStatus ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: managerStatus == "Active"
                                    ? ThemeColors.mainColor
                                    : ThemeColors.grey1,
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              data1["managerName"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: MySize.size40),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .managerDetails
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemeColors.black1,
                                      fontSize: MySize.size14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size22),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .phone
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemeColors.grey1,
                                      fontSize: MySize.size10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size6),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                children: [
                                  SvgPicture.asset(icphone),
                                  SizedBox(width: MySize.size8),
                                  Expanded(
                                    child: Text(
                                      data1["contact"].toString(),
                                      style: TextStyle(
                                        color: ThemeColors.black1,
                                        fontSize: MySize.size10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MySize.size61,
                                    height: MySize.size22,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0.50,
                                            color: ThemeColors.mainColor),
                                        borderRadius:
                                            BorderRadius.circular(MySize.size5),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .call
                                          .toString(),
                                      style: TextStyle(
                                        color: ThemeColors.mainColor,
                                        fontSize: MySize.size8,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size6),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: const Divider(color: ThemeColors.grey3),
                            ),
                            SizedBox(height: MySize.size10),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .email
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemeColors.grey1,
                                      fontSize: MySize.size10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size6),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                children: [
                                  SvgPicture.asset(icmail),
                                  SizedBox(width: MySize.size8),
                                  Expanded(
                                    child: Text(
                                      data1["mangerEmail"].toString(),
                                      style: TextStyle(
                                        color: ThemeColors.black1,
                                        fontSize: MySize.size10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MySize.size61,
                                    height: MySize.size22,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0.50,
                                            color: ThemeColors.mainColor),
                                        borderRadius:
                                            BorderRadius.circular(MySize.size5),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .email
                                          .toString(),
                                      style: TextStyle(
                                        color: ThemeColors.mainColor,
                                        fontSize: MySize.size8,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size6),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: const Divider(color: ThemeColors.grey3),
                            ),
                            SizedBox(height: MySize.size10),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .address
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemeColors.grey1,
                                      fontSize: MySize.size10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size6),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: ThemeColors.mainColor,
                                    size: MySize.size14,
                                  ),
                                  SizedBox(width: MySize.size8),
                                  Expanded(
                                    child: Text(
                                      data1["address"].toString(),
                                      style: TextStyle(
                                        color: ThemeColors.black1,
                                        fontSize: MySize.size10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size6),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: const Divider(color: ThemeColors.grey3),
                            ),
                            SizedBox(height: MySize.size23),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .branch
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemeColors.black1,
                                      fontSize: MySize.size16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size23),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("restaurants")
                                  .doc(widget.restaurantRef)
                                  .collection('branches')
                                  .snapshots(),
                              builder: (context, ss) {
                                if (ss.hasData) {
                                  var newData = ss.data!.docs.toList();

                                  for (var i = 0; i < newData.length; i++) {
                                    if (newData[i]["managerDocId"] ==
                                        widget.managerRef) {
                                      branchList.clear();
                                      branchList.add(BranchModel.fromJson(
                                          newData[i].data()));
                                    }
                                  }
                                  return branchList.isNotEmpty
                                      ? BranchCard(
                                          image: widget.restaurantImage,
                                          name: branchList.first.name ?? "",
                                          backgroundColor: ThemeColors.bgColor,
                                          address:
                                              branchList.first.address ?? "",
                                          branchtype: branchList
                                                      .first.activeOrDeactive ==
                                                  "Active"
                                              ? AppLocalizations.of(context)!
                                                  .active
                                                  .toString()
                                              : AppLocalizations.of(context)!
                                                  .deactive
                                                  .toString(),
                                          btncolor: ThemeColors.mainColor,
                                        )
                                      : Text(
                                          "Branch not Assigned",
                                          style: TextStyle(
                                              fontSize: MySize.size12),
                                        );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: MySize.size50),
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
              },
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

  manageDetailsBottomSheet({required BuildContext context}) {
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
                child: Consumer<AddEditManagerProvider>(
                  builder: (context, p, child) => !p.showLoader
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: MySize.size20),
                            TextButton(
                              onPressed: () {
                                p.activeDeactiveManager(
                                  managerRef: widget.managerRef,
                                  restaurantRef: widget.restaurantRef,
                                  activeDeactive: managerStatus == "Active"
                                      ? "Deactive"
                                      : "Active",
                                  context: context,
                                );
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: Text(
                                managerStatus == "Active"
                                    ? AppLocalizations.of(context)!
                                        .deactive
                                        .toString()
                                    : AppLocalizations.of(context)!
                                        .active
                                        .toString(),
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
                                    builder: (context) => AddEditManagerView(
                                      type: "Edit",
                                      managerRef: widget.managerRef,
                                      restaurantRef: widget.restaurantRef,
                                    ),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
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
                              onPressed: () async {
                                Navigator.pop(context);
                                customDeleteDialog(context: context);
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
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
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
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
                        )
                      : SizedBox(
                          height: MySize.size300,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
              ),
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
                          // delete manager with widget.ref
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
                Consumer<AddEditManagerProvider>(
                  builder: (context, p, child) => SizedBox(
                    width: MySize.size117,
                    height: MySize.size36,
                    child: CustomButton8(
                      text: AppLocalizations.of(context)!.delete.toString(),
                      radius: MySize.size30,
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      onPressed: () async {
                        // Navigator.popUntil(context, (route) => route.isFirst);
                        await p.deleteManager(
                          ref: widget.managerRef,
                          deleteStatus: deleteStatuss == "notDeleted"
                              ? "deleted"
                              : "notDeleted",
                          context: context,
                        );
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
