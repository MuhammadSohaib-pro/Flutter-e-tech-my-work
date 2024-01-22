import 'package:event_manager_app/helper/common_functions.dart';
import 'package:event_manager_app/helper/mySize.dart';
import 'package:event_manager_app/helper/theme_helper.dart';
import 'package:event_manager_app/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:event_manager_app/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';

class KitchenAddEditItemView extends StatefulWidget {
  const KitchenAddEditItemView({super.key, required this.process});
  final String process;

  @override
  State<KitchenAddEditItemView> createState() => _KitchenAddEditItemViewState();
}

class _KitchenAddEditItemViewState extends State<KitchenAddEditItemView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MySize.size80),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: Container(
                      height: MySize.size173,
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MySize.size5),
                        ),
                      ),
                      child: Icon(
                        Icons.image,
                        size: MySize.size45,
                        color: ThemeColors.grey1,
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size8),
                  Text(
                    AppLocalizations.of(context)!.uploadImage.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: MySize.size40),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: CustomTextField13(
                      controller: TextEditingController(),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      hintText: AppLocalizations.of(context)!.title.toString(),
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
                      controller: TextEditingController(),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      hintText: AppLocalizations.of(context)!.price.toString(),
                      fillColor: ThemeColors.fillColor,
                      validator: (value) {
                        return CommonFunctions.validateTextField(value);
                      },
                    ),
                  ),
                  SizedBox(height: MySize.size10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MySize.size32),
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
                      padding: EdgeInsets.symmetric(horizontal: MySize.size20),
                      child: DropdownMenu<String>(
                        width: MySize.screenWidth / 1.3,
                        hintText: AppLocalizations.of(context)!
                            .selectCategory
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
                          DropdownMenuEntry(
                              value: "Main Items", label: "Main Items"),
                          DropdownMenuEntry(value: "Sweets", label: "Sweets"),
                          DropdownMenuEntry(
                              value: "Beverages", label: "Beverages"),
                          DropdownMenuEntry(
                              value: "Side Items", label: "Side Items"),
                        ],
                        onSelected: (value) {
                          print(value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MySize.size32),
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
                      padding: EdgeInsets.symmetric(horizontal: MySize.size20),
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
                  SizedBox(height: MySize.size10),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: CustomTextField13(
                      controller: TextEditingController(),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      hintText:
                          AppLocalizations.of(context)!.description.toString(),
                      fillColor: ThemeColors.fillColor,
                      maxLines: 5,
                      validator: (value) {
                        return CommonFunctions.validateTextField(value);
                      },
                    ),
                  ),
                  SizedBox(height: MySize.size20),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: CustomButton8(
                      text: widget.process == "Add"
                          ? AppLocalizations.of(context)!.add.toString()
                          : AppLocalizations.of(context)!.save.toString(),
                      radius: MySize.size30,
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: MySize.size60),
                ],
              ),
            ),
            Container(
              height: MySize.size60,
              width: double.infinity,
              color: ThemeColors.bgColor,
              child: Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new,
                          color: ThemeColors.black1, size: MySize.size20),
                    ),
                    Text(
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
                    Text(
                      AppLocalizations.of(context)!.cancel.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
