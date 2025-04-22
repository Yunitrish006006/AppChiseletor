import 'package:flutter/material.dart';

abstract class ThemeInterface {
  /// Theme identifier, used internally
  String get name;

  /// Get localized theme name
  String getLocalizedName(BuildContext context);

  /// Light theme data
  ThemeData get lightTheme;

  /// Dark theme data
  ThemeData get darkTheme;
}
