import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class AddPostFourView extends StatefulWidget {
  const AddPostFourView({super.key});

  @override
  State<AddPostFourView> createState() => _AddPostFourViewState();
}

class _AddPostFourViewState extends State<AddPostFourView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Image.asset(imgRequestSubmit),
            ),
            SizedBox(height: MySize.size12, width: MySize.safeWidth),
            Text(
              AppLocalizations.of(context)!.submitActivityDone.toString(),
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: MySize.size8, width: MySize.safeWidth),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Text(
                AppLocalizations.of(context)!.submitActivityDoneDescrp.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.grey1,
                  fontSize: MySize.size10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.previewActivity.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: MySize.size35),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: CustomButton8(
                text: AppLocalizations.of(context)!.backToHome.toString(),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const BottomNavBarView(),
                  //   ),
                  // );
                },
                backgroundColor: ThemeColors.mainColor,
                radius: MySize.size30,
              ),
            ),
            SizedBox(height: MySize.size20),
          ],
        ),
      ),
    );
  }
}
