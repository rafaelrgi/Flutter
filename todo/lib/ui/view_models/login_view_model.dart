import 'package:flutter/material.dart';

//Singleton para facilitar; UNDONE: implementar injeção de dependência
final loginViewModel = LoginViewModel();

class LoginViewModel extends ChangeNotifier {
  //

  bool _isLoggedIn = false;
  final loginCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final loginFocus = FocusNode();
  final passwordFocus = FocusNode();

  String? loginError;
  String? passwordError;
  bool get isLoggedIn => _isLoggedIn;

  void onSubmit() {
    final login = loginCtrl.text;
    final password = passwordCtrl.text;

    _isLoggedIn = false;
    loginError = login.isNotEmpty ? null : 'Please inform your login';
    passwordError = password.isNotEmpty ? null : 'Please inform your password';

    if (loginError == null && passwordError == null) {
      //UNDONE: check login credentials
      _isLoggedIn = true;
    }

    if (loginError != null) {
      loginFocus.requestFocus();
    } else if (passwordError != null) {
      passwordFocus.requestFocus();
    }

    notifyListeners();
    return;
  }

  @override
  void dispose() {
    loginCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
