import 'package:event_app/helper/imports.dart';

class MenuProvider with ChangeNotifier {
  bool _notificationFlag = true;

  bool get notificationFlag => _notificationFlag;

  setNotificationFlag(bool value) {
    _notificationFlag = value;
    notifyListeners();
  }
}
