import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GrayTheme implements ThemeInterface {
  @override
  String get name => 'gray';

  @override
  String getLocalizedName(BuildContext context) {
    return AppLocalizations.of(context)!.themeGray;
  }

  @override
  ThemeData get lightTheme => ThemeData(
        colorSchemeSeed: Colors.grey[700],
        brightness: Brightness.light,
      );

  @override
  ThemeData get darkTheme => ThemeData(
        colorSchemeSeed: Colors.grey,
        brightness: Brightness.dark,
      );
}
