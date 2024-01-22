import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier {
  BottomNavBarProvider() {
    _bottomNavBarIndex = 0;
  }

  int _bottomNavBarIndex = 0;

  int get bottomIndex => _bottomNavBarIndex;

  setBottomIndex(int value) {
    _bottomNavBarIndex = value;
    notifyListeners();
  }
}
