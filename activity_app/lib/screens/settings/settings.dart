import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/component/custom_buttons.dart';
import 'package:activityapp/global/component/custom_textfields.dart';
import 'package:activityapp/global/component/scrollable_columns.dart';
import 'package:activityapp/global/layout/sizes_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../global/component/divider.dart';
import '../../global/layout/asset_images.dart';
import '../../global/layout/mySize.dart';
import '../../global/layout/sizeconfig.dart';
import '../../languages/LocaleString.dart';
import '../../provider/switch_provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  late bool notificationSwitch = true;
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    final switchProvider = Provider.of<SwitchProvider>(context, listen: false);
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            //Notification
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AssetImages.notification),
                    SizedBox(
                      width: width(context) * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocale.getStarted.getString(context),
                          style: TextStyle(
                              fontSize: MySize.size11,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyText),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocale.notification.getString(context),
                          style: TextStyle(
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w500),

                          // AppLocale.notification.getString(context),
                          // style: text16500,
                        )
                      ],
                    ),
                  ],
                ),
                Consumer<SwitchProvider>(builder: (context, value, child) {
                  return FlutterSwitch(
                    activeColor: AppColors.primaryColor,
                    inactiveColor: const Color(0xffE5E5E5),
                    width: 30.0,
                    height: 20.0,
                    toggleSize: 15.0,
                    value: switchProvider.notificationSwitch,
                    borderRadius: 20.0,
                    padding: 2.0,
                    showOnOff: false,
                    onToggle: (val) {
                      switchProvider.updateNotification(val);

                      notificationSwitch = val;
                      // FirebaseFirestore.instance
                      //     .collection('User')
                      //     .doc(FirebaseAuth.instance.currentUser!.uid)
                      //     .update({'notification': val});
                    },
                  );
                })
              ],
            ),
            SizedBox(
              height: MySize.size5,
            ),

            const Divider_con(),

            SizedBox(
              height: MySize.size5,
            ),
            //Language
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    Text(AppLocale.language.getString(context)),
                                content: SizedBox(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          localization.translate('en');
                                          Navigator.pop(context);
                                        },
                                        title: const Text("English"),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          localization.translate('ar');
                                          Navigator.pop(context);
                                        },
                                        title: const Text("Arabic"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        // Get.find<LocalizationController>().toggleLanguage();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetImages.translate),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.language.getString(context),
                                style: TextStyle(
                                    fontSize: MySize.size11,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.greyText),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                localization.currentLocale.toString() == 'en'
                                    ? 'English'
                                    : 'عربي',
                                style: TextStyle(
                                    fontSize: MySize.size16,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MySize.size5,
            ),

            const Divider_con(),

            SizedBox(
              height: MySize.size5,
            ),
            //version
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AssetImages.version),
                    SizedBox(
                      width: width(context) * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocale.aboutApp.getString(context),
                          style: TextStyle(
                              fontSize: MySize.size11,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyText),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Version 1.01',
                          style: TextStyle(
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w500),

                          // AppLocale.notification.getString(context),
                          // style: text16500,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MySize.size5,
            ),

            const Divider_con(),

            SizedBox(
              height: MySize.size5,
            ),
            //account Delete
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    customConfirmationDialog(context);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetImages.deleteAccount),
                      SizedBox(
                        width: width(context) * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delete Account',
                            style: TextStyle(
                                fontSize: MySize.size11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyText),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Permanent Delete',
                            style: TextStyle(
                                fontSize: MySize.size16,
                                fontWeight: FontWeight.w500),

                            // AppLocale.notification.getString(context),
                            // style: text16500,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButtonContainer(
                      containerColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      onTap: () {},
                      buttonText: AppLocale.logOut.getString(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  customConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size20),
          ),
          child: Container(
            height: MySize.size340,
            width: double.infinity,
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
            child: ScrollableColumn(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(MySize.size20, MySize.size15,
                      MySize.size20, MySize.size10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: MySize.size20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Delete Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size10),
                Padding(
                  padding: Spacing.horizontal(MySize.size25),
                  child: Text(
                    "Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF9F9F9F),
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: MySize.size20),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    title: "Enter Your Password",
                    fillColor: const Color(0xFFF6F6F6),
                    sufixIcon: const Icon(
                      Icons.visibility_outlined,
                      color: AppColors.primaryColor,
                    ),
                    radius: MySize.size30,
                    validator: (value) {
                      if (value == null || value.isNotEmpty) {
                        return "Field is Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: "Delete",
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.ticketcolor,
                    radius: MySize.size30,
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
