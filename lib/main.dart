import 'package:app_chiseletor/plugins/gray_theme.dart';
import 'package:app_chiseletor/plugins/my_custom_theme.dart';
import 'package:app_chiseletor/theme/app_initializer.dart';
import 'package:app_chiseletor/auth/auth_wrapper.dart';
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
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    handleError(details.exception, details.stack ?? StackTrace.empty);
  };
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final providers = await AppInitializer.initialize(
    customThemes: [MyCustomTheme(), GrayTheme()],
    defaultLocale: const Locale('zh', 'TW'),
  );

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
    return const ThemedMaterialApp(
      home: AuthWrapper(
        homepage: MyHomePage(
          title: 'Flutter Demo',
          child: DemoContent(),
        ),
      ),
    );
  }
}
