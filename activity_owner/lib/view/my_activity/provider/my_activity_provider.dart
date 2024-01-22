import 'package:flutter/cupertino.dart';

class MyActivityProvider with ChangeNotifier {
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  settabValue(int value) {
    _tabIndex = value;
    notifyListeners();
  }
}
