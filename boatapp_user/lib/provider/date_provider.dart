import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DateProvider with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  String newDate = '';
  Future<void> selectDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: selectedDate,
        lastDate: DateTime(2100));
    if (date != null) {
      newDate = date.toString().split(' ')[0];
    }
    notifyListeners();
  }
  String endDate = '';
  Future<void> selectEndDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: selectedDate,
        lastDate: DateTime(2100));
    if (date != null) {
      endDate = date.toString().split(' ')[0];
    }
    notifyListeners();
  }


}