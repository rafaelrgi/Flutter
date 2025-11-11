import 'package:todo/core/config.dart';
import 'package:todo/ui/appTheme.dart';
import 'package:todo/ui/pages/login_view.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/pages/todos_view.dart';

main() {
  runApp(TodoApp());
}

//------------------------------------------------------------------------------
class TodoApp extends StatelessWidget {
  //
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appController,
      builder: (context, __) {
        return MaterialApp(
          title: 'ToDo',
          debugShowCheckedModeBanner: false,
          //Theme
          themeMode: appController.themeMode,
          theme: AppTheme.buildTheme(false),
          darkTheme: AppTheme.buildTheme(true),
          //Routes
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginView(),
            '/home': (context) => const TodosView(),
            '/todos': (context) => const TodosView(),
          },
        );
      },
    );
  }
}
//------------------------------------------------------------------------------

final appController = AppController();

class AppController extends ChangeNotifier {
  //
  ThemeMode _type = ThemeMode.system;

  ThemeMode get themeMode => _type;

  AppController() {
    _init();
  }

  _init() async {
    themeMode = await Config.getTheme();
  }

  set themeMode(ThemeMode val) {
    _type = val;
    notifyListeners();
  }
}
//------------------------------------------------------------------------------