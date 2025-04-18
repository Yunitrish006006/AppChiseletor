import 'package:flutter/material.dart';
import 'theme_data.dart';
import 'theme_interface.dart'; // Import ThemeInterface

class ThemeManager extends ChangeNotifier {
  ThemeInterface? _currentTheme;
  List<ThemeInterface> pluginThemes = [];
  List<String> get availableThemes =>
      ['default'] + pluginThemes.map((theme) => theme.name).toList();

  ThemeInterface? get currentTheme => _currentTheme;

  Future<void> loadTheme(String themeName) async {
    final pluginTheme = pluginThemes.firstWhere(
      (theme) => theme.name == themeName,
      orElse:
          () => AppThemeData(
            name: '',
            lightTheme: ThemeData(),
            darkTheme: ThemeData(),
          ),
    );

    if (pluginTheme.name.isNotEmpty) {
      _currentTheme = pluginTheme;
      notifyListeners();
      return;
    }

    if (!availableThemes.contains(themeName)) {
      print('Theme $themeName not supported, loading default theme.');
      await loadDefaultTheme();
      return;
    }

    if (themeName == 'default') {
      _currentTheme = AppThemeData(
        name: 'Default Theme',
        lightTheme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
      );
    }
    notifyListeners(); //  確保調用 notifyListeners()
  }

  Future<void> loadDefaultTheme() async {
    _currentTheme = AppThemeData(
      name: 'Default Theme',
      lightTheme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
    notifyListeners();
  }

  ThemeData applyTheme(BuildContext context) {
    if (_currentTheme == null) {
      loadDefaultTheme();
      return ThemeData.light();
    }
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? _currentTheme!.darkTheme : _currentTheme!.lightTheme;
  }

  void toggleBrightness(BuildContext context) {
    //  重命名為 toggleBrightness
    if (_currentTheme == null) {
      loadDefaultTheme();
      return;
    }
    final currentTheme = _currentTheme!;
    final isCurrentlyDark =
        Theme.of(context).brightness ==
        Brightness.dark; //  使用 Theme.of(context).brightness
    _currentTheme = AppThemeData(
      name: currentTheme.name,
      lightTheme:
          isCurrentlyDark
              ? currentTheme.lightTheme
              : currentTheme.darkTheme, //  根據 isCurrentlyDark 調整
      darkTheme:
          isCurrentlyDark ? currentTheme.darkTheme : currentTheme.lightTheme,
    );
    notifyListeners();
  }

  void registerPluginTheme(ThemeInterface pluginTheme) {
    pluginThemes.add(pluginTheme);
    notifyListeners();
  }
}
