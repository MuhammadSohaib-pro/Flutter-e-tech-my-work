import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier {
  int _bottomIndex = 0;
  bool _iconAndColorFlag = false;

  int get bottomIndex => _bottomIndex;
  bool get iconAndColorFlag => _iconAndColorFlag;

  setBottomValue(int value) {
    _bottomIndex = value;
    notifyListeners();
  }

  setIconAndColorFlagValue(bool value) {
    _iconAndColorFlag = value;
    notifyListeners();
  }
}
