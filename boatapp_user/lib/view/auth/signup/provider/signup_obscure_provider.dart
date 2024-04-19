import 'package:flutter/cupertino.dart';

class SignUpObscureProvider with ChangeNotifier{
  bool _obsecureText1 = true;

  bool get obsecureText1 => _obsecureText1;

  setObsecureText1(bool value) {
    _obsecureText1 = value;
    notifyListeners();
  }

  bool _obsecureText2 = true;

  bool get obsecureText2 => _obsecureText2;

  setObsecureText2(bool value) {
    _obsecureText2 = value;
    notifyListeners();
  }

}