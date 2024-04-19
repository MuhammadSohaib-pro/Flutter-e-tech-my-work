import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Back_Arrow extends StatelessWidget {
  final VoidCallback? ontap;
  Color color;
  String? image;
   Back_Arrow({Key? key, this.ontap, this.color=Colors.black, this.image='assets/icons/Back.svg'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: SvgPicture.asset(image!, color: color,));
  }
}

