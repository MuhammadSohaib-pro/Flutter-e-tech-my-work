import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  double? startTime = 0.0;
  double? endTime = 1439.0; // 1439 represents 11:59 PM in minutes
  int iTime = 1439;
  int hoursTime = 0;

  void updateTime(RangeValues value) {
    startTime = value.start.toDouble();
    endTime = value.end.toDouble();
    iTime = endTime!.toInt() - startTime!.toInt();
    if (kDebugMode) {
      print(iTime);
    }
    notifyListeners();
  }
}
