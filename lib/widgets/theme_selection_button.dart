import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';

class ThemeSelectionButton extends StatelessWidget {
  const ThemeSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.format_paint,
      ), // You can choose a more appropriate icon
      onSelected: (String themeName) {
        themeManager.loadTheme(themeName);
      },
      itemBuilder: (BuildContext context) {
        return themeManager.availableThemes.map((String themeName) {
          return PopupMenuItem<String>(
            value: themeName,
            child: Text(themeName),
          );
        }).toList();
      },
    );
  }
}
