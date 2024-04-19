import 'package:flutter/foundation.dart';

class LoadingProvider2 with ChangeNotifier{
  bool _loading2 = false;
  bool get loading2 => _loading2;
  void loginLoading2(bool value){
    _loading2 = value;
    notifyListeners();
  }


}
