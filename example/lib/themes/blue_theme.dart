import 'package:app_chiseletor_example/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_interface.dart';

class BlueTheme implements ThemeInterface {
  @override
  String get name => 'blue';

  @override
  String getLocalizedName(BuildContext context) {
    return AppLocalizations.of(context)!.themeBlue;
  }

  @override
  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        brightness: Brightness.light,
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.blue[50],
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      );

  @override
  ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[700],
        brightness: Brightness.dark,
        canvasColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[800],
        appBarTheme: AppBarTheme(
          color: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[700],
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.grey),
        ),
      );
}
