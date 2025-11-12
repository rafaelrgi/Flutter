import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginViewModel extends ChangeNotifier {
  //
  static LoginViewModel get instance => GetIt.instance<LoginViewModel>();

  bool _isLoggedIn = false;
  final loginCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final loginFocus = FocusNode();
  final passwordFocus = FocusNode();

  String? loginError;
  String? passwordError;
  bool get isLoggedIn => _isLoggedIn;

  bool onSubmit() {
    final login = loginCtrl.text;
    final password = passwordCtrl.text;

    _isLoggedIn = false;
    loginError = login.isNotEmpty ? null : 'Please inform your login';
    passwordError = password.isNotEmpty ? null : 'Please inform your password';

    if (loginError == null && passwordError == null) {
      //we don't check login credentials, anything is good!
      _isLoggedIn = true;
    }

    if (loginError != null) {
      loginFocus.requestFocus();
    } else if (passwordError != null) {
      passwordFocus.requestFocus();
    }

    notifyListeners();
    return _isLoggedIn;
  }

  @override
  void dispose() {
    loginCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
