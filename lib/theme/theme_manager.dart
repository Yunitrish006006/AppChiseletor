import 'package:flutter/material.dart';
import 'theme_data.dart';
import 'theme_interface.dart'; // Import ThemeInterface

class ThemeManager extends ChangeNotifier {
  ThemeInterface? _currentTheme;
  ThemeMode? _themeMode = ThemeMode.system; // 設定初始值
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
      debugPrint('Theme $themeName not supported, loading default theme.');
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
    notifyListeners();
  }

  Future<void> loadDefaultTheme() async {
    _currentTheme = AppThemeData(
      name: 'Default Theme',
      lightTheme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
    notifyListeners();
  }

  ThemeData darkTheme(BuildContext context) {
    return _currentTheme?.darkTheme ?? ThemeData.dark();
  }

  ThemeData lightTheme(BuildContext context) {
    return _currentTheme?.lightTheme ?? ThemeData.light();
  }

  ThemeData getReverse(BuildContext context) {
    if (themeMode(context) == ThemeMode.system) {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return lightTheme(context);
      } else {
        return darkTheme(context);
      }
    } else {
      if (themeMode(context) == ThemeMode.dark) {
        return lightTheme(context);
      } else {
        return darkTheme(context);
      }
    }
  }

  ThemeMode themeMode(BuildContext context) {
    return _themeMode ?? ThemeMode.system;
  }

  void toggleThemeMode(BuildContext context) {
    //  重命名
    //thememode 在system,light,dark中切換
    _themeMode =
        _themeMode == ThemeMode.system
            ? ThemeMode.light
            : _themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.system;
    notifyListeners();
  }

  void registerPluginTheme(ThemeInterface pluginTheme) {
    pluginThemes.add(pluginTheme);
    notifyListeners();
  }
}
