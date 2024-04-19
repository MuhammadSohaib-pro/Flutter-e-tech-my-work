import 'package:flutter/material.dart';

class RatingTileProvider with ChangeNotifier{
  bool _everything = false;
  bool get everything => _everything;

  bool _boat = false;
  bool get boat => _boat;

  bool _service = false;
  bool get service => _service;

  bool _communtication = false;
  bool get communtication => _communtication;

  bool _loveIt = false;
  bool get loveIt => _loveIt;

  void changeEverything(bool value){
    _everything = value;
    notifyListeners();
  }
  void changeBoat(bool value){
    _boat = value;
    notifyListeners();
  }
  void changeService(bool value){
    _service = value;
    notifyListeners();
  }
  void changeCommunication(bool value){
    _communtication = value;
    notifyListeners();
  }
  void changeLoveIt(bool value){
    _loveIt = value;
    notifyListeners();
  }

}