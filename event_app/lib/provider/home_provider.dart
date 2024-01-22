import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _indicatorIndex = 0;
  int get indicatorIndex => _indicatorIndex;
  setIndicatorIndex(int value) {
    _indicatorIndex = value;
    notifyListeners();
  }
}
