import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_interface.dart'; // 確保路徑正確

class GrayTheme implements ThemeInterface {
  @override
  String get name => 'gray';

  @override
  ThemeData get lightTheme => ThemeData(
    colorSchemeSeed: Colors.grey[700],
    brightness: Brightness.light,
  );

  @override
  ThemeData get darkTheme =>
      ThemeData(colorSchemeSeed: Colors.grey, brightness: Brightness.dark);
}
