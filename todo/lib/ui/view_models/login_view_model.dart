import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginViewModel extends ChangeNotifier {
  //
  static LoginViewModel get instance => GetIt.instance<LoginViewModel>();

  final loginFocus = FocusNode();
  final passwordFocus = FocusNode();
  bool _loginChanged = false;
  bool _passwordChanged = false;
  String _login = '', _password = '';

  void setLogin(String val) {
    _login = val;
    _loginChanged = true;
    notifyListeners();
  }

  void setPassword(String val) {
    _password = val;
    _passwordChanged = true;
    notifyListeners();
  }

  String? validateLogin() {
    return !_loginChanged || _login.isNotEmpty
        ? null
        : 'Please inform your login';
  }

  String? validatepassword() {
    return !_passwordChanged || _password.isNotEmpty
        ? null
        : 'Please inform your login';
  }

  bool doLogin() {
    //force the validation of fields, if not validated yet
    _loginChanged = true;
    _passwordChanged = true;
    notifyListeners();

    //we don't check login credentials, anything is good!
    if (_login.isEmpty) {
      loginFocus.requestFocus();
      return false;
    }
    if (_password.isEmpty) {
      passwordFocus.requestFocus();
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    loginFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
