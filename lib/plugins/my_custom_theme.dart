import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_interface.dart'; // 確保路徑正確

class MyCustomTheme implements ThemeInterface {
  @override
  String get name => 'My Custom Theme';

  @override
  ThemeData get lightTheme => ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    brightness: Brightness.light,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[100], //  Scaffold 背景色
    appBarTheme: AppBarTheme(
      color: Colors.green,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    //  ... 其他自定義屬性，例如 textTheme, iconTheme, etc.
  );

  @override
  ThemeData get darkTheme => ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.green[700],
    brightness: Brightness.dark,
    canvasColor: Colors.grey[900],
    scaffoldBackgroundColor: Colors.grey[800],
    appBarTheme: AppBarTheme(
      color: Colors.green[700],
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green[700],
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.grey),
    ),
    //  ... 其他自定義屬性
  );
}
