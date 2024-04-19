import 'package:flutter/cupertino.dart';

class CountDownProvider  with ChangeNotifier{
  String _canceled = 'false';
  String get canceled => _canceled;
  void getCancel(String value){
    _canceled = value;
    notifyListeners();
  }

}