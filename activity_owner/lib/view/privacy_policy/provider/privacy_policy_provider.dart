import 'package:flutter/material.dart';

class PrivacyPolicyProvider with ChangeNotifier {
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  setTabValue(int value) {
    _tabIndex = value;
    notifyListeners();
  }
}
