import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeScreenTileProvider with ChangeNotifier{
  int? _selectedIndex  = -1;
  String? _getName = 'All';

  int? get selectedIndex => _selectedIndex;
  String? get getName => _getName;

  void updateSelectedIndex(int index, String name) {
    _selectedIndex = index;
    _getName = name;
    notifyListeners();
  }
}