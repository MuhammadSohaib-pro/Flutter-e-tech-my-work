import 'package:elabd_ems_admin/helper/import_helper.dart';

class ButtonComp extends StatelessWidget {
  final String title;
  final Color backColor;
  final double bordeRadius;
  final Function onTap;
  final Color borderColor;
  final Color textColor;

  const ButtonComp({
    super.key,
    required this.title,
    this.textColor = whiteColor,
    this.borderColor = Colors.transparent,
    this.backColor = primaryColor,
    this.bordeRadius = 8,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        // height: MySize.size28,
        // width: MySize.size80,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: backColor,
            borderRadius: BorderRadius.circular(bordeRadius)),
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size20, vertical: 8),
          child: Text(
            title,
            style: poppinMedium.copyWith(
                color: textColor, fontSize: MySize.size12),
          ),
        )),
      ),
    );
  }
}
