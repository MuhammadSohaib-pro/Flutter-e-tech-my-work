import 'package:event_manager_app/helper/common_functions.dart';
import 'package:event_manager_app/helper/constant.dart';
import 'package:event_manager_app/helper/mySize.dart';
import 'package:event_manager_app/helper/theme_helper.dart';
import 'package:event_manager_app/screens/services_details/services_add_edit_item_view.dart';
import 'package:event_manager_app/widgets/custom_buttons.dart';
import 'package:event_manager_app/widgets/custom_textfields.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ServiceDetailsView extends StatefulWidget {
  const ServiceDetailsView({super.key});

  @override
  State<ServiceDetailsView> createState() => _ServiceDetailsViewState();
}

// String selectedTab = 'New';

class _ServiceDetailsViewState extends State<ServiceDetailsView>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  bool iconAndColorFlag = false;
  late TabController _tabController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _tabController = TabController(length: 4, vsync: this);
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        title: Text(
          AppLocalizations.of(context)!.services.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: Spacing.horizontal(MySize.size10),
            child: Center(
              child: PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      AppLocalizations.of(context)!.delete.toString(),
                      style: TextStyle(
                        color: ThemeColors.red,
                        fontSize: MySize.size10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      AppLocalizations.of(context)!.edit.toString(),
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
                padding: const EdgeInsets.all(0),
                onSelected: (value) {
                  if (value == 2) {
                    customAddEditBottomSheet(context, "Edit");
                  }
                  if (value == 1) {
                    customDeleteDialog(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MySize.size20),
            DefaultTabController(
              length: 4,
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelStyle: TextStyle(
                  color: ThemeColors.grey1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w400,
                ),
                labelStyle: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w400,
                ),
                unselectedLabelColor: ThemeColors.grey1,
                labelColor: ThemeColors.black1,
                labelPadding: const EdgeInsets.all(0),
                tabs: [
                  Text(
                    AppLocalizations.of(context)!.mainItems.toString(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.sideItems.toString(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.sweet.toString(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.beverage.toString(),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size26),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () => customDetailModalSheet(context),
                        child: Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ServicesAddEditItemView(
                                                process: "Edit"),
                                      ),
                                    );
                                  },
                                  backgroundColor: const Color(0xff008B48),
                                  foregroundColor: ThemeColors.bgColor,
                                  icon: Icons.edit,
                                  autoClose: true,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    customDeleteDialog(context);
                                  },
                                  backgroundColor: const Color(0xFFE70505),
                                  foregroundColor: ThemeColors.bgColor,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                  icon: Icons.delete_outlined,
                                  autoClose: true,
                                ),
                              ],
                            ),
                            child: Container(
                              width: double.infinity,
                              height: MySize.size100,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 20,
                                    offset: Offset(4, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: Spacing.horizontal(MySize.size15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MySize.size60,
                                      height: MySize.size60,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x358B0000),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              MySize.size10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: MySize.size8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Full Lamb\nMandi',
                                            style: TextStyle(
                                              color: ThemeColors.black1,
                                              fontSize: MySize.size14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            'SAR 15000.00',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: ThemeColors.mainColor,
                                              fontSize: MySize.size12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () => customDetailModalSheet(context),
                        child: Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ServicesAddEditItemView(
                                                process: "Edit"),
                                      ),
                                    );
                                  },
                                  backgroundColor: const Color(0xff008B48),
                                  foregroundColor: ThemeColors.bgColor,
                                  icon: Icons.edit,
                                  autoClose: true,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    customDeleteDialog(context);
                                  },
                                  backgroundColor: const Color(0xFFE70505),
                                  foregroundColor: ThemeColors.bgColor,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                  icon: Icons.delete_outlined,
                                  autoClose: true,
                                ),
                              ],
                            ),
                            child: Container(
                              width: double.infinity,
                              height: MySize.size100,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 20,
                                    offset: Offset(4, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: Spacing.horizontal(MySize.size15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MySize.size60,
                                      height: MySize.size60,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x358B0000),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              MySize.size10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: MySize.size8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Full Lamb\nMandi',
                                            style: TextStyle(
                                              color: ThemeColors.black1,
                                              fontSize: MySize.size14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            'SAR 15000.00',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: ThemeColors.mainColor,
                                              fontSize: MySize.size12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () => customDetailModalSheet(context),
                        child: Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ServicesAddEditItemView(
                                                process: "Edit"),
                                      ),
                                    );
                                  },
                                  backgroundColor: const Color(0xff008B48),
                                  foregroundColor: ThemeColors.bgColor,
                                  icon: Icons.edit,
                                  autoClose: true,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    customDeleteDialog(context);
                                  },
                                  backgroundColor: const Color(0xFFE70505),
                                  foregroundColor: ThemeColors.bgColor,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                  icon: Icons.delete_outlined,
                                  autoClose: true,
                                ),
                              ],
                            ),
                            child: Container(
                              width: double.infinity,
                              height: MySize.size100,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 20,
                                    offset: Offset(4, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: Spacing.horizontal(MySize.size15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MySize.size60,
                                      height: MySize.size60,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x358B0000),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              MySize.size10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: MySize.size8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Full Lamb\nMandi',
                                            style: TextStyle(
                                              color: ThemeColors.black1,
                                              fontSize: MySize.size14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            'SAR 15000.00',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: ThemeColors.mainColor,
                                              fontSize: MySize.size12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () => customDetailModalSheet(context),
                        child: Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ServicesAddEditItemView(
                                                process: "Edit"),
                                      ),
                                    );
                                  },
                                  backgroundColor: const Color(0xff008B48),
                                  foregroundColor: ThemeColors.bgColor,
                                  icon: Icons.edit,
                                  autoClose: true,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    customDeleteDialog(context);
                                  },
                                  backgroundColor: const Color(0xFFE70505),
                                  foregroundColor: ThemeColors.bgColor,
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                  icon: Icons.delete_outlined,
                                  autoClose: true,
                                ),
                              ],
                            ),
                            child: Container(
                              width: double.infinity,
                              height: MySize.size100,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(MySize.size10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 20,
                                    offset: Offset(4, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: Spacing.horizontal(MySize.size15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MySize.size60,
                                      height: MySize.size60,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x358B0000),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              MySize.size10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: MySize.size8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Full Lamb\nMandi',
                                            style: TextStyle(
                                              color: ThemeColors.black1,
                                              fontSize: MySize.size14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            'SAR 15000.00',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: ThemeColors.mainColor,
                                              fontSize: MySize.size12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: AppLocalizations.of(context)!.addItems.toString(),
            iconColor: Colors.black,
            bubbleColor: Colors.black,
            icon: Icons.settings,
            titleStyle:
                TextStyle(fontSize: MySize.size10, color: ThemeColors.bgColor),
            onPress: () {
              _animationController.reverse();
              setState(() {
                iconAndColorFlag = !iconAndColorFlag;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ServicesAddEditItemView(process: "Add"),
                ),
              );
            },
          ),
          Bubble(
            title: AppLocalizations.of(context)!.addCategory.toString(),
            iconColor: Colors.black,
            bubbleColor: Colors.black,
            icon: Icons.add,
            titleStyle:
                TextStyle(fontSize: MySize.size10, color: ThemeColors.bgColor),
            onPress: () {
              _animationController.reverse();
              setState(() {
                iconAndColorFlag = !iconAndColorFlag;
              });
              customAddEditBottomSheet(context, "Add");
            },
          ),
        ],
        animation: _animation,
        onPress: () => {
          _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
          setState(() {
            iconAndColorFlag = !iconAndColorFlag;
          })
        },
        iconColor: ThemeColors.bgColor,
        iconData: iconAndColorFlag ? Icons.close : Icons.add,
        backGroundColor:
            iconAndColorFlag ? ThemeColors.black1 : ThemeColors.mainColor,
      ),
    );
  }

  customDeleteDialog(BuildContext context) {
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
                SizedBox(
                  width: MySize.size117,
                  height: MySize.size36,
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.delete.toString(),
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

  customAddEditBottomSheet(BuildContext context, String process) async {
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
                height: MySize.size320,
                decoration: BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MySize.size30),
                    topRight: Radius.circular(MySize.size30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          Spacing.fromLTRB(0, MySize.size20, 0, MySize.size30),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          process == "Add"
                              ? AppLocalizations.of(context)!
                                  .addCategory
                                  .toString()
                              : AppLocalizations.of(context)!
                                  .editCategory
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: CustomTextField13(
                        controller: TextEditingController(),
                        hintText: AppLocalizations.of(context)!
                            .categoryName
                            .toString(),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        fillColor: ThemeColors.fillColor,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return CommonFunctions.validateTextField(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: Spacing.fromLTRB(MySize.size32, MySize.size10,
                          MySize.size32, MySize.size30),
                      child: Container(
                        width: double.infinity,
                        height: MySize.size50,
                        decoration: ShapeDecoration(
                          color: ThemeColors.fillColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(MySize.size10),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: MySize.size20),
                        child: DropdownMenu<String>(
                          width: MySize.screenWidth / 1.3,
                          hintText: AppLocalizations.of(context)!
                              .selectBranch
                              .toString(),
                          textStyle: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                          trailingIcon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: ThemeColors.black1,
                            size: MySize.size24,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0),
                            hintStyle: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(value: "All", label: "All"),
                            DropdownMenuEntry(
                                value: "Saudi Arabia, Riyadh",
                                label: "Saudi Arabia, Riyadh"),
                            DropdownMenuEntry(
                                value: "Saudi Arabia, Al-Kharaj",
                                label: "Saudi Arabia, Al-Kharaj")
                          ],
                          onSelected: (value) {
                            print(value);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: Spacing.fromLTRB(
                          MySize.size32, 0, MySize.size32, MySize.size20),
                      child: CustomButton8(
                        text: process == "Add"
                            ? AppLocalizations.of(context)!.add.toString()
                            : AppLocalizations.of(context)!.save.toString(),
                        onPressed: () {},
                        backgroundColor: ThemeColors.mainColor,
                        textColor: ThemeColors.bgColor,
                        radius: MySize.size30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> customDetailModalSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MySize.size270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: AssetImage(
                          imgRoastedLamb2,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: Spacing.all(MySize.size20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: ThemeColors.bgColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'Roast lamb',
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'But the pain itself is important, and the client will follow. Now freedom is at times free and desired, and trucks hate property. The chapter is suitable for silent partners who resort to the beaches through our marriages, through Hymenaean projects.',
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '500.00 SAR',
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_rate_rounded,
                            color: ThemeColors.yellow, size: MySize.size16),
                        SizedBox(width: MySize.size4),
                        Text(
                          '5.0',
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MySize.size150,
                      height: MySize.size50,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: ThemeColors.mainColor),
                          borderRadius: BorderRadius.circular(MySize.size30),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x21623C03),
                            blurRadius: 20,
                            offset: Offset(2, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.edit.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    Container(
                      width: MySize.size150,
                      height: MySize.size50,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: ThemeColors.mainColor),
                          borderRadius: BorderRadius.circular(MySize.size30),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x21623C03),
                            blurRadius: 20,
                            offset: Offset(2, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.delete.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
            ],
          ),
        );
      },
    );
  }
}
