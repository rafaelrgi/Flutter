import 'package:todo/ui/view_models/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  //

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo')),
      body: Center(
        heightFactor: 1.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            reverse: true,
            child: ListenableBuilder(
              listenable: loginViewModel,
              builder: (BuildContext context, Widget? child) {
                if (loginViewModel.isLoggedIn) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => Navigator.of(context).pushReplacementNamed('/home'),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: loginViewModel.onSubmit,
                      child: const Text('Log In'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
