import 'package:flutter/cupertino.dart';

class FilterProvider with ChangeNotifier{
  int? _sPrice ;
  int? _ePrice ;
  int? get sprice => _sPrice;
  int? get eprice => _ePrice;

  int? _sPassengers ;
  int? _ePassengers ;
  int? get spassengers => _sPassengers;
  int? get epassengers => _ePassengers;

  String? _boatType ;
  int? _boatIndex ;

  String? get boatType => _boatType;
  int? get boatindex => _boatIndex;

  void updateFilter(int sprices,eprices, spassenger, epassenger, boatIndexes,String boat){
    _boatType = boat;
    _boatIndex = boatIndexes;

    _sPassengers = spassenger;
    _ePassengers = epassenger;

    _sPrice = sprices;
    _ePrice = eprices;

    notifyListeners();
  }
}