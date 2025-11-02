import 'package:calculator/ui/pages/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  //

  static const bool _darkTheme = true;
  static const Color _color = Colors.blueGrey;
  static const bool _whiteTitle = true;

  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _color,
          brightness: _darkTheme ? Brightness.dark : Brightness.light,
        ),
        appBarTheme: _darkTheme
            ? const AppBarTheme()
            : const AppBarTheme(
                backgroundColor: _color,
                foregroundColor: _whiteTitle ? Colors.white : Colors.black,
                systemOverlayStyle: _whiteTitle
                    ? SystemUiOverlayStyle.light
                    : SystemUiOverlayStyle.dark,
                elevation: 4,
                shadowColor: Colors.black,
              ),
      ),
      home: HomeView(),
    );
  }
}
