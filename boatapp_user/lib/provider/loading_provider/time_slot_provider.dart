import 'package:flutter/cupertino.dart';

class TimeSlotProvider with ChangeNotifier{
  int? _index ;
  int? get index => _index;
  String? value1;
  void updateSLot(int value, String time){
    _index = value;
    value1 = time;
    notifyListeners();
  }
  void clearSlot(){
    _index = null;
    value1 = null;
  }
}