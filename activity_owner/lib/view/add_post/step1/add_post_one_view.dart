import 'package:activity_owner/helper/common_functions.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/add_post/step2/add_post_two_view.dart';
import 'package:activity_owner/view/add_post/components/custom_circular_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:activity_owner/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';

class AddPostOneView extends StatefulWidget {
  const AddPostOneView({super.key});

  @override
  State<AddPostOneView> createState() => _AddPostOneViewState();
}

class _AddPostOneViewState extends State<AddPostOneView> {
  @override
  Widget build(BuildContext context) {
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
                value: "1/3", indicatorValue: 0.33),
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
                  AppLocalizations.of(context)!.images.toString(),
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
                  AppLocalizations.of(context)!.uptofiveImages.toString(),
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
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: MySize.size102,
                          height: MySize.size102,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/102x102"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MySize.size20,
                            height: MySize.size20,
                            decoration: const ShapeDecoration(
                              shape: CircleBorder(),
                              color: ThemeColors.grey3,
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.close,
                              color: ThemeColors.grey1,
                              size: MySize.size16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: MySize.size10),
                    Container(
                      width: MySize.size102,
                      height: MySize.size102,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1,
                              color: Color(0xFFAAB1F6),
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add,
                        color: const Color(0xFFAAB1F6),
                        size: MySize.size45,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  fillColor: ThemeColors.fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: AppLocalizations.of(context)!.title.toString(),
                  title: AppLocalizations.of(context)!.title.toString(),
                  keyboardType: TextInputType.text,
                  radius: 30,
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
                  hintText: AppLocalizations.of(context)!.description.toString(),
                  title: AppLocalizations.of(context)!.description.toString(),
                  keyboardType: TextInputType.text,
                  radius: 30,
                  maxLines: 5,
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
                  title: AppLocalizations.of(context)!.pricePerHour.toString(),
                  hintText: AppLocalizations.of(context)!.price.toString(),
                  keyboardType: TextInputType.number,
                  radius: 30,
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
                  hintText: AppLocalizations.of(context)!.noOfPerson.toString(),
                  title: AppLocalizations.of(context)!.maxPerson.toString(),
                  keyboardType: TextInputType.text,
                  radius: 30,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value, context),
                ),
              ),
              SizedBox(height: MySize.size40),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.next.toString(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPostTwoView(),
                      ),
                    );
                  },
                  radius: MySize.size30,
                  backgroundColor: ThemeColors.mainColor,
                ),
              ),
              SizedBox(height: MySize.size20),
            ],
          ),
        ),
      ),
    );
  }
}
