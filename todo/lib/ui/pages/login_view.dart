import 'package:todo/ui/pages/todos_view.dart';
import 'package:todo/ui/view_models/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  //
  const LoginView({super.key});

  void _onSubmit(BuildContext ctx) {
    final loginViewModel = LoginViewModel.instance;
    final navigator = Navigator.of(ctx);

    if (loginViewModel.doLogin()) {
      navigator.pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 650),
          pageBuilder: (_, _, _) => TodosView(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final loginViewModel = LoginViewModel.instance;
    final theme = Theme.of(ctx);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const .symmetric(horizontal: 16),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              children: [
                const SizedBox(height: 16),
                Hero(
                  tag: 'icon',
                  child: Image.asset('assets/icons/app_icon_m.png'),
                ),
                const SizedBox(height: 16),
                Text('Todo', style: theme.textTheme.headlineLarge),
                const SizedBox(height: 32),
                ListenableBuilder(
                  listenable: loginViewModel,
                  builder: (_, _) {
                    return Column(
                      children: [
                        TextField(
                          onChanged: loginViewModel.setLogin,
                          focusNode: loginViewModel.loginFocus,
                          decoration: InputDecoration(
                            labelText: 'Login',
                            errorText: loginViewModel.validateLogin(),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextField(
                          onChanged: loginViewModel.setPassword,
                          focusNode: loginViewModel.passwordFocus,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: loginViewModel.validatepassword(),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => _onSubmit(ctx),
                  child: const Text('Log In'),
                ),
                const SizedBox(height: 64),
                const Text('*Type anything in the fields Login and Password'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
