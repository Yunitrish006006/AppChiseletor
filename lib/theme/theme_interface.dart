import 'package:flutter/material.dart';

abstract class ThemeInterface {
  String get name;
  ThemeData get lightTheme;
  ThemeData get darkTheme;
}
