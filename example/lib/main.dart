import 'package:app_chiseletor/auth/auth_wrapper.dart';
import 'package:app_chiseletor/theme/app_initializer_singleton.dart';
import 'package:app_chiseletor/widgets/theme_material_app_singleton.dart';
import 'package:app_chiseletor_example/pages/demo_content.dart';
import 'package:app_chiseletor_example/pages/homepage.dart';
import '../l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/my_custom_theme.dart';
import '../themes/blue_theme.dart';
import 'package:app_chiseletor/theme/theme_manager_singleton.dart';

void handleError(Object error, StackTrace stack) {
  debugPrint('ERROR: $error\nSTACK: $stack');
}

void main() async {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    handleError(details.exception, details.stack ?? StackTrace.empty);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 使用單例模式初始化主題管理器
  await ThemeManagerSingleton.initialize(
    customThemes: [
      MyCustomTheme(),
      BlueTheme(),
    ],
  );
  // 使用新的單例版本的 AppInitializer
  final providers = await AppInitializerSingleton.initialize(
    defaultLocale: const Locale('zh', 'TW'),
    externalSupportedLocales: AppLocalizations.supportedLocales,
  );

  runApp(
    MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) => const ThemedMaterialAppSingleton(
          debugShowCheckedModeBanner: false,
          home: AuthWrapper(
            homepage: HomePage(child: DemoContent()),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    ),
  );
}
