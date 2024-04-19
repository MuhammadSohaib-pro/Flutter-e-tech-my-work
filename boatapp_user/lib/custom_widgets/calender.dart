// import 'package:flutter/material.dart';
//
// class Calender{
//   DateTime selectedDate = DateTime.now();
//   String newDate = '';
//   Future<String> selectDate(BuildContext context) async {
//     final date = await showDatePicker(
//         context: context,
//         firstDate: DateTime(1900),
//         initialDate: selectedDate,
//         lastDate: DateTime(2100));
//     if (date != null) {
//       newDate = date.toString().split(' ')[0];
//       return date.toString().split(' ')[0];
//     } else {
//       return selectedDate.toString().split(' ')[0];
//     }
//   }
// }