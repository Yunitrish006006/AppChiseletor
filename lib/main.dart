import 'package:app_chiseletor/home_page.dart';
import 'package:app_chiseletor/l10n/locale_provider.dart';
import 'package:app_chiseletor/plugins/gray_theme.dart';
import 'package:app_chiseletor/widgets/auth_wrapper.dart';
import 'package:app_chiseletor/widgets/theme_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme/theme_manager.dart';
import 'auth/auth_manager.dart';
import 'plugins/my_custom_theme.dart';

// 全局錯誤處理
void handleError(Object error, StackTrace stack) {
  debugPrint('ERROR: $error\nSTACK: $stack');
  // 這裡可以添加錯誤報告服務，如 Sentry 或 Firebase Crashlytics
}

Future<void> main() async {
  // 確保 Flutter 綁定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 設置錯誤處理
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    handleError(details.exception, details.stack ?? StackTrace.empty);
  };

  // 設置平台錯誤處理
  ErrorWidget.builder = (details) {
    return Material(
      child: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error: ${details.exception}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  };

  // 設置應用程式方向
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 初始化 Firebase
  await Firebase.initializeApp();

  // 初始化主題管理
  final themeManager = ThemeManager();
  await themeManager.loadTheme('default');

  // 註冊自定義主題
  themeManager.registerPluginTheme(MyCustomTheme());
  themeManager.registerPluginTheme(GrayTheme());

  // 運行應用程式
  runApp(
    // 使用 Provider 進行狀態管理
    MultiProvider(
      providers: [
        // 主題管理
        ChangeNotifierProvider.value(value: themeManager),
        // 認證管理
        ChangeNotifierProvider(create: (_) => AuthenticationManager()),
        // 語言管理
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedMaterialApp(
      home: AuthWrapper(
        homepage: const MyHomePage(
          title: 'Flutter Demo',
          // 展示不同的 widget 示例
          child: DemoContent(),
        ),
      ),
    );
  }
}
