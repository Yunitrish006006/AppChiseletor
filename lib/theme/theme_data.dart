import 'package:flutter/material.dart';
import 'theme_interface.dart'; // Import the ThemeInterface

class AppThemeData implements ThemeInterface {
  @override
  final ThemeData lightTheme;
  @override
  final ThemeData darkTheme;
  @override
  final String name;

  AppThemeData({
    required this.lightTheme,
    required this.darkTheme,
    required this.name,
  });

  @override
  String getLocalizedName(BuildContext context) {
    throw UnimplementedError();
  }
}
