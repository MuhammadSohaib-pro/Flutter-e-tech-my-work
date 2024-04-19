import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MyBookingProvider with ChangeNotifier{
  int? _selectedIndex  = 0;
  String? _getStatus = 'All';

  int? get selectedIndex => _selectedIndex;
  String? get getStatus => _getStatus;

  void updateSelectedIndex(int index, String status) {
    _selectedIndex = index;
    _getStatus = status;
    notifyListeners();
  }
}