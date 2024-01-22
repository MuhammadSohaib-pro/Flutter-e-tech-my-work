import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier {
  int _bottomIndex = 0;
  int get bottomIndex => _bottomIndex;
  changeBottomIndexValue(int value) {
    _bottomIndex = value;
    notifyListeners();
  }
}
