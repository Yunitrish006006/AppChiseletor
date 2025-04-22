import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';

class ThemeSelectionButton extends StatelessWidget {
  const ThemeSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeManager.getReverse(context).canvasColor,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.format_paint,
          color: themeManager.getReverse(context).canvasColor,
        ),
        onSelected: (String themeName) {
          themeManager.loadTheme(themeName);
        },
        itemBuilder: (BuildContext context) {
          return themeManager.pluginThemes.map((theme) {
            return PopupMenuItem<String>(
              value: theme.name,
              child: Text(theme.getLocalizedName(context)),
            );
          }).toList();
        },
      ),
    );
  }
}
