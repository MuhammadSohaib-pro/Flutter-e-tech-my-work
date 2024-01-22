import 'package:flutter/material.dart';

class SwitchProvider extends ChangeNotifier {
  bool _notificationSwitch = true;

  bool get notificationSwitch => _notificationSwitch;

  void updateNotification(bool newValue) {
    _notificationSwitch = newValue;
    notifyListeners();
  }
}