import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTrackOrderCard extends StatelessWidget {
  const CustomTrackOrderCard({
    super.key,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.iconColor,
    required this.iconBgColor,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color iconColor;
  final Color iconBgColor;
  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: double.infinity,
        height: MySize.size70,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: Spacing.horizontal(MySize.size20),
          child: Row(
            children: [
              Container(
                  width: MySize.size30,
                  height: MySize.size30,
                  decoration: ShapeDecoration(
                    color: iconBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(icon)),
              SizedBox(width: MySize.size15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: MySize.size5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
