import 'package:app_chiseletor/theme/default_theme.dart';
import 'package:flutter/material.dart';
import 'theme_interface.dart';

/// 主題管理器，採用單例模式實現全局訪問
class ThemeManagerSingleton extends ChangeNotifier {
  // 單例實例
  static final ThemeManagerSingleton _instance =
      ThemeManagerSingleton._internal();

  // 工廠構造函數，返回單例實例
  factory ThemeManagerSingleton() => _instance;

  // 私有構造函數，防止外部直接創建實例
  ThemeManagerSingleton._internal() {
    // 初始化操作
    _themeMode = ThemeMode.system;
    pluginThemes = [DefaultTheme()];
    // 默認載入默認主題
    _currentTheme = DefaultTheme();
  }

  // 靜態訪問方式
  static ThemeManagerSingleton get instance => _instance;

  ThemeInterface? _currentTheme;
  ThemeMode? _themeMode;
  late List<ThemeInterface> pluginThemes;
  List<String> get availableThemes =>
      pluginThemes.map((theme) => theme.name).toList();

  ThemeInterface? get currentTheme => _currentTheme;

  /// 初始化主題管理器
  static Future<void> initialize(
      {List<ThemeInterface> customThemes = const []}) async {
    // 載入默認主題
    await instance.loadTheme('default');

    // 註冊自定義主題
    for (var theme in customThemes) {
      instance.registerPluginTheme(theme);
    }
  }

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

  ThemeData darkTheme() {
    return _currentTheme?.darkTheme ?? DefaultTheme().darkTheme;
  }

  ThemeData lightTheme() {
    return _currentTheme?.lightTheme ?? DefaultTheme().lightTheme;
  }

  /// 獲取當前主題數據，基於當前的主題模式
  ThemeData getCurrent(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      // 對於系統主題，檢查平台亮度
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return darkTheme();
      } else {
        return lightTheme();
      }
    } else if (_themeMode == ThemeMode.dark) {
      return darkTheme();
    } else {
      return lightTheme();
    }
  }

  /// 獲取當前主題的反向主題數據
  ThemeData getReverse(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return lightTheme();
      } else {
        return darkTheme();
      }
    } else {
      if (_themeMode == ThemeMode.dark) {
        return lightTheme();
      } else {
        return darkTheme();
      }
    }
  }

  /// 獲取當前主題模式
  ThemeMode themeMode() {
    return _themeMode ?? ThemeMode.system;
  }

  /// 切換主題模式（系統 -> 淺色 -> 深色 -> 系統）
  void toggleThemeMode() {
    switch (_themeMode) {
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
        break;
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }

  void registerPluginTheme(ThemeInterface pluginTheme) {
    pluginThemes.add(pluginTheme);
    notifyListeners();
  }
}
