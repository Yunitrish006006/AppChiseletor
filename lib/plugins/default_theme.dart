import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DefaultTheme implements ThemeInterface {
  @override
  String get name => 'default';

  @override
  String getLocalizedName(BuildContext context) {
    return AppLocalizations.of(context)!.themeDefault;
  }

  @override
  ThemeData get lightTheme => ThemeData.light();

  @override
  ThemeData get darkTheme => ThemeData.dark();
}
