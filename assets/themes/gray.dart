import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_data.dart';

final theme = AppThemeData(
  name: 'Gray',
  lightTheme: ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.light,
    // 其他自定義屬性...
  ),
  darkTheme: ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    // 其他自定義屬性...
  ),
);
