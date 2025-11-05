import 'package:todo/ui/appTheme.dart';
import 'package:todo/ui/pages/login_view.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/pages/todos_view.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  //

  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'ToDo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/home': (context) => const TodosView(),
        '/todos': (context) => const TodosView(),
      },
    );

    return app;
  }
}
