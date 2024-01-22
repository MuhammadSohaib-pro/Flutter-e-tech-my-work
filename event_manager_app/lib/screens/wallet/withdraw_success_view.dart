import 'package:event_manager_app/helper/constant.dart';
import 'package:event_manager_app/helper/mySize.dart';
import 'package:event_manager_app/helper/theme_helper.dart';
import 'package:event_manager_app/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class WithdrawSuccessView extends StatelessWidget {
  const WithdrawSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ThemeColors.bgColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(imgWithdrawSucces),
            const SizedBox(height: 0, width: double.infinity),
            Text(
              AppLocalizations.of(context)!.withdrawDoneDescrp.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: CustomButton8(
                text: AppLocalizations.of(context)!.backToHome.toString(),
                onPressed: () {
                  Navigator.pop(context);
                },
                radius: MySize.size30,
                backgroundColor: ThemeColors.mainColor,
              ),
            ),
            SizedBox(height: MySize.size30),
          ],
        ),
      ),
    );
  }
}
