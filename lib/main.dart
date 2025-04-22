import 'package:app_chiseletor/plugins/gray_theme.dart';
import 'package:app_chiseletor/plugins/my_custom_theme.dart';
import 'package:app_chiseletor/theme/app_initializer.dart';
import 'package:app_chiseletor/widgets/auth_wrapper.dart';
import 'package:app_chiseletor/widgets/theme_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

// 全局錯誤處理
void handleError(Object error, StackTrace stack) {
  debugPrint('ERROR: $error\nSTACK: $stack');
  // 這裡可以添加錯誤報告服務，如 Sentry 或 Firebase Crashlytics
}

Future<void> main() async {
  // 設置錯誤處理
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    handleError(details.exception, details.stack ?? StackTrace.empty);
  };

  // 確保 Flutter binding 初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 Firebase
  await Firebase.initializeApp();

  // 初始化應用程式
  final providers = await AppInitializer.initialize(
    customThemes: [MyCustomTheme(), GrayTheme()],
    defaultLocale: const Locale('zh', 'TW'),
  );

  // 運行應用程式
  runApp(
    MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) => const MyApp(),
      ),
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
          child: DemoContent(),
        ),
      ),
    );
  }
}
