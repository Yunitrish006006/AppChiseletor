import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_chiseletor/l10n/app_localizations.dart';
import '../theme/theme_manager.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  String _getThemeModeName(BuildContext context, ThemeMode mode) {
    final l10n = AppLocalizations.of(context)!;
    switch (mode) {
      case ThemeMode.system:
        return l10n.themeModeSystem;
      case ThemeMode.light:
        return l10n.themeModeLight;
      case ThemeMode.dark:
        return l10n.themeModeDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final currentThemeMode = themeManager.themeMode(context);
    IconData icon;
    String tooltip;

    switch (currentThemeMode) {
      case ThemeMode.system:
        icon = Icons.brightness_auto;
        tooltip = _getThemeModeName(context, ThemeMode.system);
        break;
      case ThemeMode.light:
        icon = Icons.light_mode;
        tooltip = _getThemeModeName(context, ThemeMode.light);
        break;
      case ThemeMode.dark:
        icon = Icons.dark_mode;
        tooltip = _getThemeModeName(context, ThemeMode.dark);
        break;
    }

    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: () {
        themeManager.toggleThemeMode(context);
      },
    );
  }
}
