import 'package:activity_owner/helper/common_functions.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/add_post/components/custom_circular_bar.dart';
import 'package:activity_owner/view/add_post/step3/add_post_three_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:activity_owner/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';

class AddPostTwoView extends StatefulWidget {
  const AddPostTwoView({super.key});

  @override
  State<AddPostTwoView> createState() => _AddPostTwoViewState();
}

List<int> intervalsList = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];

class _AddPostTwoViewState extends State<AddPostTwoView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.addActivity.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: Spacing.all(MySize.size10),
            child: CustomCircleProgressIndicator(
                value: "2/3", indicatorValue: 0.66),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.selectLocation.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: MySize.size2),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.locationOfActivity.toString(),
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  height: MySize.size172,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: MySize.safeWidth,
                          decoration: const BoxDecoration(
                            color: ThemeColors.grey2,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MySize.safeWidth,
                        height: MySize.size42,
                        decoration: const ShapeDecoration(
                          color: ThemeColors.bgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        // alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.near_me_outlined,
                              color: ThemeColors.mainColor,
                              size: MySize.size30,
                            ),
                            Text(
                              AppLocalizations.of(context)!.selectLocation.toString(),
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.availability.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.monday.toString(),
                        onPressed: () {},
                        radius: 30,
                        backgroundColor: ThemeColors.mainColor,
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.tuesday.toString(),
                        onPressed: () {},
                        radius: 30,
                        backgroundColor: ThemeColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.wednesday.toString(),
                        onPressed: () {},
                        radius: 30,
                        backgroundColor: ThemeColors.mainColor,
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.thursday.toString(),
                        onPressed: () {},
                        radius: 30,
                        backgroundColor: ThemeColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.friday.toString(),
                        onPressed: () {},
                        radius: 30,
                        backgroundColor: ThemeColors.fillColor,
                        textColor: ThemeColors.grey1,
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.saturday.toString(),
                        onPressed: () {},
                        radius: 30,
                        backgroundColor: ThemeColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.sunday.toString(),
                        onPressed: () {},
                        radius: 30,
                        backgroundColor: ThemeColors.mainColor,
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    Expanded(
                      child: CustomButton8(
                        text: "",
                        onPressed: () {},
                        radius: 30,
                        backgroundColor: ThemeColors.bgColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  fillColor: ThemeColors.fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  title: AppLocalizations.of(context)!.startTime.toString(),
                  hintText: "00:00",
                  keyboardType: TextInputType.number,
                  radius: 30,
                  sufixIcon: const Icon(
                    Icons.access_time_filled_rounded,
                    color: ThemeColors.mainColor,
                  ),
                  validator: (value) =>
                      CommonFunctions.validateTextField(value, context),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  fillColor: ThemeColors.fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  title: AppLocalizations.of(context)!.endTime.toString(),
                  hintText: "00:00",
                  keyboardType: TextInputType.number,
                  radius: 30,
                  sufixIcon: const Icon(
                    Icons.access_time_filled_rounded,
                    color: ThemeColors.mainColor,
                  ),
                  validator: (value) =>
                      CommonFunctions.validateTextField(value, context),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: GestureDetector(
                  // onTap: () => intervalsBottomSheet(context),
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    fillColor: ThemeColors.fillColor,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    title: AppLocalizations.of(context)!.intervals.toString(),
                    hintText: "00 Minute",
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    radius: 30,
                    onTap: () {
                      intervalsBottomSheet(context);
                    },
                    // validator: (value) =>
                    //     CommonFunctions.validateTextField(value, context),
                  ),
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.selectMatches.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'DP1 ',
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '(1vs1)',
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'DP2 ',
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '(2vs2)',
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'DP1 ',
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '(3vs3)',
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              
              SizedBox(height: MySize.size40),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.back.toString(),
                        onPressed: () {},
                        radius: MySize.size30,
                        backgroundColor: ThemeColors.fillColor,
                        textColor: ThemeColors.grey1,
                      ),
                    ),
                    SizedBox(width: MySize.size20),
                    Expanded(
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.next.toString(),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddPostThreeView(),
                            ),
                          );
                        },
                        radius: 30,
                        backgroundColor: ThemeColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
            ],
          ),
        ),
      ),
    );
  }

  intervalsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      builder: (BuildContext context) {
        return Container(
          height: MySize.size300,
          decoration: const BoxDecoration(
              color: ThemeColors.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          padding:
              Spacing.fromLTRB(MySize.size32, MySize.size12, MySize.size32, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontWeight: FontWeight.w400,
                    fontSize: MySize.size14,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: 0,
                  ),
                  itemExtent: 50,
                  onSelectedItemChanged: (int index) {},
                  children: List.generate(
                    intervalsList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          "${intervalsList[index]} min",
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontWeight: FontWeight.w700,
                            fontSize: MySize.size16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: ThemeColors.mainColor,
                    fontWeight: FontWeight.w400,
                    fontSize: MySize.size14,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
