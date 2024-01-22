import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/nointernet/nointernet_view.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:activity_owner/widgets/scrollable_column.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final defaultPinTheme = PinTheme(
    width: MySize.size50,
    height: MySize.size50,
    textStyle: TextStyle(
        fontSize: MySize.size20,
        color: ThemeColors.mainColor,
        fontWeight: FontWeight.w600),
    margin: Spacing.horizontal(MySize.size10),
    decoration: BoxDecoration(
      color: ThemeColors.grey3,
      borderRadius: BorderRadius.circular(MySize.size10),
    ),
  );

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
            AppLocalizations.of(context)!.verifyYourOTP.toString(),
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
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!
                        .verifyYourOTPDescrp
                        .toString(),
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '\n+966 21753713',
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: MySize.size50),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Column(
              children: [
                Pinput(
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  validator: (s) {
                    return s == '2222' ? null : 'Pin is incorrect';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
                SizedBox(height: MySize.size25),
                Text(
                  AppLocalizations.of(context)!.didntRecieved.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.mainColor,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: CustomButton8(
              text: AppLocalizations.of(context)!.confirm.toString(),
              radius: MySize.size30,
              backgroundColor: ThemeColors.mainColor,
              textColor: ThemeColors.bgColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoInternetView(),
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
