import 'package:counter_bloc/blocs/counter_block.dart';
import 'package:counter_bloc/pages/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  //
  //just a blank line for readability

  static const bool _darkTheme = false;
  static const Color _color = Colors.orange;
  static const bool _whiteTitle = true;

  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Bloc',
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
      home: BlocProvider(create: (_) => CounterCubit(), child: CounterPage()),
    );
  }
}
