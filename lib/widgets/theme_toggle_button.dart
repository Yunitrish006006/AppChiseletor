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
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Theme.of(context).brightness ==
                    Brightness
                        .light //  使用 Theme.of(context).brightness
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          onPressed: () {
            themeManager.toggleBrightness(context); //  使用 toggleBrightness
          },
        ),
        const ThemeSelectionButton(),
      ],
    );
  }
}
