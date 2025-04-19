import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';
import 'theme_selection_button.dart'; // Import ThemeSelectionButton

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final currentThemeMode = themeManager.themeMode(context);
    IconData icon;

    switch (currentThemeMode) {
      case ThemeMode.system:
        icon = Icons.brightness_auto;
        break;
      case ThemeMode.light:
        icon = Icons.light_mode;
        break;
      case ThemeMode.dark:
        icon = Icons.dark_mode;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {
            themeManager.toggleThemeMode(context);
          },
        ),
        const ThemeSelectionButton(),
      ],
    );
  }
}
