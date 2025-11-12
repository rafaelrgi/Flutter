import 'package:todo/ui/view_models/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  //

  const LoginView({super.key});

  void _onSubmit(BuildContext ctx) {
    final loginViewModel = LoginViewModel.instance;
    if (loginViewModel.onSubmit()) {
      Navigator.of(ctx).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = LoginViewModel.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('ToDo')),
      body: Center(
        heightFactor: 1.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                ListenableBuilder(
                  listenable: loginViewModel,
                  builder: (BuildContext context, Widget? child) {
                    return Column(
                      children: [
                        TextField(
                          controller: loginViewModel.loginCtrl,
                          focusNode: loginViewModel.loginFocus,
                          decoration: InputDecoration(
                            labelText: 'Login',
                            errorText: loginViewModel.loginError,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextField(
                          controller: loginViewModel.passwordCtrl,
                          focusNode: loginViewModel.passwordFocus,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: loginViewModel.passwordError,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => _onSubmit(context),
                  child: const Text('Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
