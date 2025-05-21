import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import '../l10n/locale_provider.dart';
import '../auth/auth_manager.dart';
import 'theme_manager_singleton.dart';
import 'theme_interface.dart';

/// 應用程序初始化器，使用單例模式的主題管理器
class AppInitializerSingleton {
  /// 初始化應用程序，返回所需的 providers
  static Future<List<SingleChildWidget>> initialize({
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

    // 主題管理器不再需要在這裡初始化，因為它是單例
    // 而且已經在 main.dart 中通過 ThemeManagerSingleton.initialize() 進行了初始化

    // 返回所需的 providers，確保正確的依賴順序
    return [
      ChangeNotifierProvider<LocaleProvider>.value(value: localeProvider),
      // 仍然需要提供 ThemeManagerSingleton，但使用 instance 而不是創建新實例
      ChangeNotifierProvider<ThemeManagerSingleton>.value(
        value: ThemeManagerSingleton.instance,
      ),
      ChangeNotifierProvider<AuthenticationManager>(
        create: (_) => AuthenticationManager(),
      ),
    ];
  }
}
