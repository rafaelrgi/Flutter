import 'package:flutter/material.dart';

import 'git/git_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //
  const MyApp({super.key});
  static const _colorLight = Colors.blue;
  static const _colorDark = Color.fromRGBO(26, 35, 126, 1);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: _colorLight,
          primaryContainer: _colorLight,
          surface: _colorLight,
          onPrimary: Colors.white,
          onPrimaryContainer: Colors.white,
          onSurface: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black26,
        colorScheme: const ColorScheme.dark(
          primary: _colorLight,
          onPrimary: Colors.white,
          primaryContainer: _colorDark
          //secondary: _colorLight,
          // onPrimaryContainer: Colors.white,
          // onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black26),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const GitPage(title: 'Git Commands Generator'),
    );
  }
}
