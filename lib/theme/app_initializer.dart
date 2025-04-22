import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import '../l10n/locale_provider.dart';
import '../auth/auth_manager.dart';
import 'theme_manager.dart';
import 'theme_interface.dart';

class AppInitializer {
  static Future<List<SingleChildWidget>> initialize({
    List<ThemeInterface> customThemes = const [],
    Locale? defaultLocale,
  }) async {
    // 確保 Flutter 綁定初始化
    WidgetsFlutterBinding.ensureInitialized();

    // 設置應用程式方向
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // 初始化 providers
    final localeProvider = LocaleProvider(defaultLocale: defaultLocale);
    final themeManager = ThemeManager();
    await themeManager.loadTheme('default');

    // 註冊自定義主題
    for (var theme in customThemes) {
      themeManager.registerPluginTheme(theme);
    }

    // 返回所需的 providers，確保正確的依賴順序
    return [
      ChangeNotifierProvider<LocaleProvider>.value(value: localeProvider),
      ChangeNotifierProvider<ThemeManager>.value(value: themeManager),
      ChangeNotifierProvider<AuthenticationManager>(
        create: (_) => AuthenticationManager(),
      ),
    ];
  }
}
