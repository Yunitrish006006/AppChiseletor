import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';
import 'theme_selection_button.dart'; // Import ThemeSelectionButton

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Row(
      // Use a Row to display both buttons
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            themeManager.currentTheme?.lightTheme == ThemeData.light()
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          onPressed: () {
            themeManager.toggleTheme(context);
          },
        ),
        const ThemeSelectionButton(), // Add ThemeSelectionButton
      ],
    );
  }
}
