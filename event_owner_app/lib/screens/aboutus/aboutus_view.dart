import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MySize.size25),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: SvgPicture.asset(icMenu, color: ThemeColors.black1),
                    ),
                    Text(
                      AppLocalizations.of(context)!.aboutUs.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Orders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                    // SvgPicture.asset(icBell, color: ThemeColors.bgColor),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: MySize.size50),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(icLoginLogo),
          ),
          SizedBox(height: MySize.size50),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Text(
              AppLocalizations.of(context)!.contactUs.toString(),
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: MySize.size20),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(icFacebook),
                SvgPicture.asset(icTwitter),
                SvgPicture.asset(icInstagram),
                SvgPicture.asset(icLinkedIn),
                SvgPicture.asset(icGmail),
              ],
            ),
          ),
          SizedBox(height: MySize.size30),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Text(
              AppLocalizations.of(context)!.aboutUs.toString(),
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: MySize.size15),
          Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Text(
              AppLocalizations.of(context)!.aboutUsDescrp.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: MySize.size10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: MySize.size50),

        ],
      ),
    );
  }
}
