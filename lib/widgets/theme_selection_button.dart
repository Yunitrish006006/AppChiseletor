import 'package:flutter/material.dart';
import '../theme/theme_manager_singleton.dart';

class ThemeSelectionButton extends StatelessWidget {
  const ThemeSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用單例模式獲取主題管理器實例
    final themeManager = ThemeManagerSingleton.instance;

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
