import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import '../l10n/locale_provider_singleton.dart';
import '../auth/auth_manager.dart';
import 'theme_manager_singleton.dart';

/// 應用程序初始化器，使用單例模式的主題管理器
class AppInitializerSingleton {
  /// 初始化應用程序，返回所需的 providers
  static Future<List<SingleChildWidget>> initialize({
    Locale? defaultLocale,
    List<Locale>? externalSupportedLocales,
  }) async {
    // 確保 Flutter 綁定初始化
    WidgetsFlutterBinding.ensureInitialized();

    // 設置應用程式方向
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // 初始化語言區域提供者
    LocaleProviderSingleton.initialize(
      defaultLocale: defaultLocale,
      externalSupportedLocales: externalSupportedLocales,
    );

    // 返回所需的 providers，確保正確的依賴順序
    return [
      // 提供 LocaleProviderSingleton 實例
      ChangeNotifierProvider<LocaleProviderSingleton>.value(
        value: LocaleProviderSingleton.instance,
      ),
      // 提供 ThemeManagerSingleton 實例
      ChangeNotifierProvider<ThemeManagerSingleton>.value(
        value: ThemeManagerSingleton.instance,
      ),
      ChangeNotifierProvider<AuthenticationManager>(
        create: (_) => AuthenticationManager(),
      ),
    ];
  }
}
