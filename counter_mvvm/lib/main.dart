import 'package:counter_mvvm/views/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  //

  static const bool _darkTheme = false;
  static const Color _color = Colors.yellow;
  static const bool _whiteTitle = false;

  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter MVVM',
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
      home: CounterView(),
    );
  }
}
