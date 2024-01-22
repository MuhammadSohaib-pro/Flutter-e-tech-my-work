import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/asset_images.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/sizes_class.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContainerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final double borderRadius,horizontalPadding;
  final Widget suffixIcon;

  ContainerTextField({
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    this.borderRadius = 30,
    this.horizontalPadding =3,
    required this.suffixIcon ,


  });

  @override
  _ContainerTextFieldState createState() => _ContainerTextFieldState();
}

class _ContainerTextFieldState extends State<ContainerTextField> {
  bool _isObscured = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.052,

      decoration: ShapeDecoration(
        color: Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
          shadows: [
            BoxShadow(
                blurRadius: 1,spreadRadius: 0,
                color: Colors.grey.withOpacity(0.5)
            )
          ]
      ),

      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
              hintStyle: MyTextStyles.myTextStylelight,
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.textMultiplier * widget.horizontalPadding,
                vertical: 10,//SizeConfig.textMultiplier * 3,
              ),
              border: InputBorder.none,
            ),
            keyboardType: widget.keyboardType,
            obscureText: _isObscured,
          ),
          if (widget.obscureText)
            IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
        ],
      ),
    );
  }
}

class ContainerTextField2 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  String? Function(String?)? validator;
  final double borderRadius,horizontalPadding;

  ContainerTextField2({
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.borderRadius = 30,
    this.horizontalPadding =3,

  });

  @override
  _ContainerTextField2State createState() => _ContainerTextField2State();
}

class _ContainerTextField2State extends State<ContainerTextField2> {
  bool _isObscured = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.052,

      decoration: ShapeDecoration(
          color: Color(0xFFF6F6F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          shadows: [
            BoxShadow(
                blurRadius: 1,spreadRadius: 0,
                color: Colors.grey.withOpacity(0.5)
            )
          ]
      ),

      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            validator: widget.validator,

            controller: widget.controller,
            decoration: InputDecoration(

              hintText: widget.hintText,
              hintStyle: MyTextStyles.myTextStylelight,
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.textMultiplier * widget.horizontalPadding,
                vertical: 10,//SizeConfig.textMultiplier * 3,
              ),
              border: InputBorder.none,
            ),
            keyboardType: widget.keyboardType,
            obscureText: _isObscured,
          ),
          if (widget.obscureText)
            IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
        ],
      ),
    );
  }
}
//
// class ContainerTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final TextInputType keyboardType;
//   final bool obscureText;
//
//   ContainerTextField({
//     required this.controller,
//     required this.hintText,
//     required this.keyboardType,
//     this.obscureText = false,
//   });
//
//   @override
//   _ContainerTextFieldState createState() => _ContainerTextFieldState();
// }
//
// class _ContainerTextFieldState extends State<ContainerTextField> {
//   bool _isObscured = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: SizeConfig.heightMultiplier * 6,
//       decoration: ShapeDecoration(
//           color: Color(0xFFF6F6F6),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//
//       ),
//
//       child: Stack(
//         alignment: Alignment.centerRight,
//         children: [
//           TextField(
//             controller: widget.controller,
//             decoration: InputDecoration(
//               hintText: widget.hintText,
//               hintStyle: MyTextStyles.myTextStylelight,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: SizeConfig.textMultiplier * 3,
//                 vertical: SizeConfig.textMultiplier * 3,
//               ),
//               border: InputBorder.none,
//             ),
//             keyboardType: widget.keyboardType,
//             obscureText: _isObscured,
//           ),
//           if (widget.obscureText)
//             IconButton(
//               icon: Icon(
//                 _isObscured ? Icons.visibility : Icons.visibility_off,
//                 color: Colors.grey,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _isObscured = !_isObscured;
//                 });
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }