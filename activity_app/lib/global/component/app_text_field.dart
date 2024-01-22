// import 'package:flutter/material.dart';
//
// class AppTextField extends StatelessWidget {
//   AppTextField({super.key,
//
//     this.height=62,
//     this.width=350,
//     this.controller,
//     this.onSaved,
//     this.validator,
//     this.isObsecure=false,
//     this.prefix,
//     this.suffix,
//     this.prefixIconButton,
//     this.suffixIconButton,
//     this.textInputSize=15,
//     this.textInputColor=const Color.fromRGBO(40, 40, 43,1),
//     this.hintText='enter value',
//     this.hintTextSize=15,
//     this.testFieldEnabled = true,
//     this.hintTextColor=const Color.fromRGBO(123, 123, 123, 1),
//     this.borderColor=const Color.fromRGBO(43, 43, 43, 1.0),
//   });
//
//   double height,width,textInputSize,hintTextSize;
//   String hintText;
//   Color textInputColor,borderColor,hintTextColor;
//   Widget? suffixIconButton,prefixIconButton,suffix,prefix;
//   bool isObsecure;
//   bool testFieldEnabled;
//   TextEditingController? controller;
//   String? Function(String?)? validator;
//   Function(String?)? onSaved;
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Container(
//       decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 blurRadius: 1,spreadRadius: 0,
//                 color: Colors.grey.withOpacity(0.5)
//             )
//           ]
//       ),
//       // height:height ,
//       width: width,
//       child: TextFormField(
//         enabled: testFieldEnabled,
//         controller: controller,
//         onSaved:onSaved,
//         validator: validator,
//         obscureText: isObsecure,
//         style: TextStyle(color: textInputColor),
//         decoration: InputDecoration(
//           fillColor:          Color(0xFFF6F6F6),
//         filled: true,
//
//             isDense: true,
//             suffixIconConstraints: const BoxConstraints(
//               minWidth: 10,
//               minHeight: 10,
//             ),
//             prefixIconConstraints: const BoxConstraints(
//               minWidth: 10,
//               minHeight: 10,
//             ),
//             prefix: prefix,
//             suffix: suffix,
//             prefixIcon: prefixIconButton ,
//             suffixIcon: suffixIconButton,
//             hintStyle: TextStyle(color:hintTextColor,fontSize:textInputSize),
//             hintText: hintText,
//             border:OutlineInputBorder(
//                 // borderSide: BorderSide(color: borderColor),
//                 borderRadius: BorderRadius.circular(16)
//             ),
//           errorBorder: OutlineInputBorder(
//               // borderSide: BorderSide(color: borderColor),
//               borderRadius: BorderRadius.circular(16)
//           )
//         ),
//       ),
//     );
//   }
// }
