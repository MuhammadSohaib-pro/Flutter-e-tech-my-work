import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/signup/request_declined_view.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RequestSuccessView extends StatefulWidget {
  const RequestSuccessView({super.key});

  @override
  State<RequestSuccessView> createState() => _RequestSuccessViewState();
}

class _RequestSuccessViewState extends State<RequestSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(imgReqSuccess),
            Text(
              AppLocalizations.of(context)!.reqSuccessDescrpOne.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.reqSuccessDescrpTwo.toString(),
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
                text: AppLocalizations.of(context)!.done.toString(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestDeclinedView(),
                    ),
                  );
                },
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
