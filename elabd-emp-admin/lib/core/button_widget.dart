import 'package:elabd_ems_admin/helper/import_helper.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.title,
    this.ontap,
    this.borderRadius = 10,
    this.borderColor = Colors.transparent,
    this.backColor = primaryColor,
    this.textColor = whiteColor,
    this.fontWeigth = FontWeight.w500,
    required this.fontSize,
  }) : super(key: key);
  final String title;
  final VoidCallback? ontap;
  final double borderRadius;
  final Color borderColor;
  final Color backColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeigth;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SizedBox(
      height: MySize.size54,
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius)),
        color: backColor,
        onPressed: ontap,
        child: Text(
          title,
          style: poppinMedium.copyWith(
              color: textColor, fontSize: fontSize, fontWeight: fontWeigth),
        ),
      ),
    );
  }
}
