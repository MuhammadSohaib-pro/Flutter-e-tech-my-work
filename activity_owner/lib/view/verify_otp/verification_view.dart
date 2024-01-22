import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/verify_otp/verify_otp_view.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:activity_owner/widgets/scrollable_column.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:activity_owner/widgets/custom_textfields.dart';

import 'package:flutter/material.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
      ),
      body: ScrollableColumn(
        children: [
          SizedBox(height: MySize.size30),
          Text(
            AppLocalizations.of(context)!.enterPhoneNumber.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.black1,
              fontSize: MySize.size24,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: MySize.size14),
          Padding(
            padding: Spacing.horizontal(MySize.size22),
            child: Text(
              AppLocalizations.of(context)!.enterPhoneNumberDescrp.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: MySize.size40),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: CountryFlagNumberTextField(
              initialvalue: "+966",
              hintText:
                  AppLocalizations.of(context)!.enterPhoneNumber.toString(),
              onChanged: (value) {},
            ),
          ),
          const Spacer(),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: CustomButton8(
              text: AppLocalizations.of(context)!.continuee.toString(),
              radius: MySize.size30,
              backgroundColor: ThemeColors.mainColor,
              textColor: ThemeColors.bgColor,
              onPressed: () {
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifyOtpView(),
                      ),
                    );
              },
            ),
          ),
          SizedBox(height: MySize.size20),
        ],
      ),
    );
  }
}
