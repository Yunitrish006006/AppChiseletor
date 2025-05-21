import 'package:flutter/material.dart';
import '../theme/theme_manager_singleton.dart';

class ThemeSelectionButton extends StatelessWidget {
  const ThemeSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用單例模式獲取主題管理器實例
    final themeManager = ThemeManagerSingleton.instance;

    // 使用AnimatedBuilder監聽主題變化，確保顏色能隨主題切換而更新
    return AnimatedBuilder(
      animation: themeManager,
      builder: (context, child) {
        return PopupMenuButton<String>(
          icon: Icon(
            Icons.format_paint,
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
        );
      },
    );
  }
}
