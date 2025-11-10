import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  //

  static const colorLight = Colors.orange;
  static final colorLight2 = Colors.orange.shade100;
  static const colorDark = Colors.blueGrey;
  static final colorDark2 = Colors.blueGrey.shade900;
  static const bool _whiteTitle = true;
  static final isDarkTheme =
      true; //TODO: MediaQuery.of(context).platformBrightness == Brightness.dark;

  static ThemeData buildTheme() {
    final color = isDarkTheme ? colorDark : colorLight;
    final color2 = isDarkTheme ? colorDark2 : colorLight2;

    return ThemeData(
      platform: TargetPlatform.iOS,
      //platform: TargetPlatform.android,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      appBarTheme: _appBarTheme(),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: color),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: color),
        ),
        //errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
        //disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.grey)),
      ),
      dialogTheme: _dialogTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          enableFeedback: false,
          backgroundColor: color,
          foregroundColor: _whiteTitle ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ElevatedButton.styleFrom(
          enableFeedback: false,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
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
    );
  }

  static AppBarTheme _appBarTheme() {
    //Keep the default color for dark theme
    return isDarkTheme
        ? AppBarTheme()
        /*
            backgroundColor: Colors.black,
            foregroundColor: _whiteTitle ? Colors.white : Colors.black,
            systemOverlayStyle: _whiteTitle
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            elevation: 4,
            shadowColor: Colors.black,
          )*/
        : AppBarTheme(
            backgroundColor: colorLight,
            foregroundColor: _whiteTitle ? Colors.white : Colors.black,
            systemOverlayStyle: _whiteTitle
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            elevation: 4,
            shadowColor: Colors.black,
          );
  }

  static DialogThemeData _dialogTheme() {
    return DialogThemeData(
      backgroundColor: isDarkTheme ? colorDark2 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}
