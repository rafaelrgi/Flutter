import 'package:flutter/material.dart';

class AppTheme {
  //

  static const colorLight = Colors.orange;
  static final colorLight2 = Colors.orange.shade100;
  static const colorDark = Colors.blueGrey;
  static final colorDark2 = Colors.blueGrey.shade900;
  static const bool _whiteTitle = true;
  //static final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

  static ThemeData buildTheme(bool isDarkTheme) {
    final color = isDarkTheme ? colorDark : colorLight;
    //final color2 = isDarkTheme ? colorDark2 : colorLight2;

    return ThemeData(
      platform: TargetPlatform.iOS,
      //platform: TargetPlatform.android,
      colorScheme: .fromSeed(
        seedColor: color,
        brightness: isDarkTheme ? .dark : .light,
      ),
      appBarTheme: _appBarTheme(isDarkTheme),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: color),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: color),
        ),
      ),
      dialogTheme: _dialogTheme(isDarkTheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          enableFeedback: false,
          backgroundColor: color,
          foregroundColor: _whiteTitle ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: .circular(2)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ElevatedButton.styleFrom(
          enableFeedback: false,
          shape: RoundedRectangleBorder(borderRadius: .circular(2)),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(enableFeedback: false),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        enableFeedback: false,
      ),
      textButtonTheme: TextButtonThemeData(
        style: IconButton.styleFrom(enableFeedback: false),
      ),
      listTileTheme: ListTileThemeData(enableFeedback: false),
    );
  }

  static AppBarTheme _appBarTheme(bool isDarkTheme) {
    //Keep the default color for dark theme
    return isDarkTheme
        ? AppBarTheme()
        : AppBarTheme(
            backgroundColor: colorLight,
            foregroundColor: _whiteTitle ? Colors.white : Colors.black,
            systemOverlayStyle: _whiteTitle ? .light : .dark,
            elevation: 4,
            shadowColor: Colors.black,
          );
  }

  static DialogThemeData _dialogTheme(bool isDarkTheme) {
    return DialogThemeData(
      backgroundColor: isDarkTheme ? colorDark2 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: .all(.circular(4))),
    );
  }
}
