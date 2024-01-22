import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'About Us',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MySize.size50),
            Align(
              alignment: Alignment.center,
              child: Image.asset(imgLogoBlue),
            ),
            SizedBox(height: MySize.size8),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Activity ',
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Owner',
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size18,
                        fontWeight: FontWeight.w700,
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
              child: Text(
                "Contact Us",
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
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const ShapeDecoration(
                      color: ThemeColors.fillColor,
                      shape: CircleBorder(),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(icGmail),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size30),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Text(
                "About Us",
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
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.\n\n Curabitur tempor quis eros tempus lacinia. Nam bibendum pellentesque quam a convallis. Sed ut vulputate nisi. Integer in felis sed leo vestibulum venenatis. Suspendisse quis arcu sem. Aenean feugiat ex eu vestibulum vestibulum. Morbi a eleifend magna. Nam metus lacus, porttitor eu mauris a, blandit ultrices nibh. Mauris sit amet magna non ligula vestibulum eleifend. Nulla varius volutpat turpis sed lacinia. Nam eget mi in purus lobortis eleifend. Sed nec ante dictum sem condimentum ullamcorper quis venenatis nisi. Proin vitae facilisis nisi, ac posuere leo.",
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
      ),
    );
  }
}
