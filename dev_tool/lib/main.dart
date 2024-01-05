import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:screen_retriever/screen_retriever.dart';

import 'features/git_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  var display = await screenRetriever.getPrimaryDisplay();
  WindowOptions windowOptions = WindowOptions(
    center: false,
    skipTaskbar: false,
    minimumSize: Size(860, display.size.height - 64),
    size: Size(880, display.size.height - 64),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await Future.delayed(const Duration(milliseconds: 256));
    await windowManager.setBounds(null,
        size: Size(880, display.size.height - 32),
        position: Offset(display.size.width - 880, 2));
    await windowManager.setAlwaysOnTop(true);
    await Future.delayed(const Duration(milliseconds: 256));
    await windowManager.setBounds(null,
        size: Size(880, display.size.height - 32),
        position: Offset(display.size.width - 880, 2));
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //
  const MyApp({super.key});
  static const _colorLight = Colors.blue;
  static const _colorDark = Color.fromRGBO(26, 35, 126, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Git Commands Generator',
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
      home: const GitPage(),
    );
  }
}
