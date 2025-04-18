import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';

class ThemeSelectionButton extends StatelessWidget {
  const ThemeSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final currentTheme = themeManager.currentTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeData =
        currentTheme != null
            ? (isDarkMode ? currentTheme.darkTheme : currentTheme.lightTheme)
            : ThemeData.light(); // Use default light theme if no theme is selected

    return PopupMenuButton<String>(
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: themeData.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.format_paint_rounded,
          color:
              themeData
                  .primaryColor, // Set the icon color to the primary color of the current theme
        ),
      ),
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
