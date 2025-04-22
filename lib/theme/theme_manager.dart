import 'package:app_chiseletor/plugins/default_theme.dart';
import 'package:flutter/material.dart';
import 'theme_interface.dart';

class ThemeManager extends ChangeNotifier {
  ThemeInterface? _currentTheme;
  ThemeMode? _themeMode = ThemeMode.system;
  List<ThemeInterface> pluginThemes = [DefaultTheme()];
  List<String> get availableThemes =>
      pluginThemes.map((theme) => theme.name).toList();

  ThemeInterface? get currentTheme => _currentTheme;

  Future<void> loadTheme(String themeName) async {
    final pluginTheme = pluginThemes.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => DefaultTheme(),
    );

    if (pluginTheme.name.isNotEmpty) {
      _currentTheme = pluginTheme;
      notifyListeners();
      return;
    }

    if (!availableThemes.contains(themeName)) {
      debugPrint('Theme $themeName not supported, loading default theme.');
      await loadTheme("default");
      return;
    }
    notifyListeners();
  }

  ThemeData darkTheme(BuildContext context) {
    return _currentTheme?.darkTheme ?? DefaultTheme().darkTheme;
  }

  ThemeData lightTheme(BuildContext context) {
    return _currentTheme?.lightTheme ?? DefaultTheme().lightTheme;
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
    switch (_themeMode) {
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
      case ThemeMode.dark:
        _themeMode = ThemeMode.system;
      default:
        _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  void registerPluginTheme(ThemeInterface pluginTheme) {
    pluginThemes.add(pluginTheme);
    notifyListeners();
  }
}
