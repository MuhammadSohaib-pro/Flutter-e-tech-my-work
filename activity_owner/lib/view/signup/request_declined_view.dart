import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RequestDeclinedView extends StatefulWidget {
  const RequestDeclinedView({super.key});

  @override
  State<RequestDeclinedView> createState() => _RequestDeclinedViewState();
}

class _RequestDeclinedViewState extends State<RequestDeclinedView> {
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
            Image.asset(imgReqDeclined),
            Text(
              AppLocalizations.of(context)!.reqDeclineDescrpOne.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.reqDeclineDescrpTwo.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size10,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: CustomButton8(
                text: AppLocalizations.of(context)!.tryAgain.toString(),
                onPressed: () {},
                backgroundColor: ThemeColors.mainColor,
                radius: MySize.size30,
              ),
            ),
            SizedBox(height: MySize.size30),
          ],
        ),
      ),
    );
  }
}
