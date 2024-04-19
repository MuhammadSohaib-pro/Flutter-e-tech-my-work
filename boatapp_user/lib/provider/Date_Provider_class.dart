import 'package:flutter/cupertino.dart';

class RangeDatePickerValueModel extends ChangeNotifier {
  List<DateTime?> value = [
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ),

  ];

  void setValue(List<DateTime?> newValue) {
    value = newValue;
    notifyListeners();
  }
}

