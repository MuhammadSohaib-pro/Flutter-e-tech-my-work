import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class ProductSizeWidget extends StatelessWidget {
  const ProductSizeWidget({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.text,
  });
  final VoidCallback onPressed;
  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MySize.size48,
        height: MySize.size48,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: ThemeColors.bgColor,
            fontSize: MySize.size12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
