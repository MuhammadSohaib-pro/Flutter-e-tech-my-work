import 'package:elabd_ems_admin/services/create_services.dart';
import 'package:flutter/foundation.dart';

class InternetStatusProvider with ChangeNotifier {
  bool _isNetAvailable = false;

  bool get isNetAvailable => _isNetAvailable;

  void checkNetwork() async {
    var isCheck = await isNetworkAvailable();
    _isNetAvailable = isCheck;
    notifyListeners();
  }
}


