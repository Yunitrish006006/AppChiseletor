import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme_data.dart';

class ThemeManager extends ChangeNotifier {
  AppThemeData? _currentTheme;
  List<String> availableThemes = ['default', 'gray']; // 新增可用主題列表

  AppThemeData? get currentTheme => _currentTheme;

  Future<void> loadTheme(String themeName) async {
    if (!availableThemes.contains(themeName)) {
      print('Theme $themeName not supported, loading default theme.');
      await loadDefaultTheme();
      return;
    }
    try {
      final fileContent = await rootBundle.loadString(
        'assets/themes/$themeName.dart',
      );
      // Assuming the theme file exports a variable named 'theme' of type 'AppThemeData'
      final theme = _parseThemeData(fileContent);
      _currentTheme = theme;
      notifyListeners();
    } catch (e) {
      print('Error loading theme $themeName: $e');
      // Load a default theme if loading fails
      await loadDefaultTheme();
    }
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

  void toggleTheme(BuildContext context) {
    if (_currentTheme == null) {
      loadDefaultTheme();
      return;
    }
    final currentTheme = _currentTheme!;
    final isCurrentlyDark = currentTheme.lightTheme == ThemeData.dark();
    _currentTheme = AppThemeData(
      name: currentTheme.name,
      lightTheme: isCurrentlyDark ? ThemeData.light() : ThemeData.dark(),
      darkTheme: isCurrentlyDark ? ThemeData.dark() : ThemeData.light(),
    );
    notifyListeners();
  }

  // Helper function to parse the Dart file content and extract the AppThemeData
  AppThemeData _parseThemeData(String fileContent) {
    // This is a placeholder and needs to be implemented properly
    //  We might use 'eval' or a similar mechanism to execute the Dart code
    //  and retrieve the 'theme' variable.
    //  For now, we'll return a default theme.
    return AppThemeData(
      name: 'Parsed Theme',
      lightTheme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
