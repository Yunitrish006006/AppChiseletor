import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_interface.dart'; // 確保路徑正確

class DefaultTheme implements ThemeInterface {
  @override
  String get name => 'default';

  @override
  ThemeData get lightTheme => ThemeData.light();

  @override
  ThemeData get darkTheme => ThemeData.dark();
}
