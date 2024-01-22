import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale? _appLocale;
  Locale? get appLocal => _appLocale;

  String _groupValue = '';
  String get groupValue => _groupValue;
  changeGroupValue(String value) {
    _groupValue = value;
    notifyListeners();
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  changeShowLoaderValue(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en');
      return null;
    }
    String local = prefs.getString('language_code') ?? 'en';
    _appLocale = Locale(local.toString());
    return null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("ar")) {
      print(type);
      _appLocale = const Locale("ar");
      _groupValue = "Arabic";
      await prefs.setString('language_code', 'ar');
    } else {
      print(type);
      _appLocale = const Locale("en");
      _groupValue = "English";
      await prefs.setString('language_code', 'en');
    }
    notifyListeners();
  }
}
