import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_interface.dart';
import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart';

class MyCustomTheme implements ThemeInterface {
  @override
  String get name => 'custom';

  @override
  String getLocalizedName(BuildContext context) {
    return AppLocalizations.of(context)!.themeCustom;
  }

  @override
  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        brightness: Brightness.light,
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          color: Colors.green,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
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
      );
}
