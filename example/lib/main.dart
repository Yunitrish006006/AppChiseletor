import 'package:app_chiseletor/auth/auth_wrapper.dart';
import 'package:app_chiseletor/theme/app_initializer.dart';
import 'package:app_chiseletor/widgets/theme_material_app.dart';
import 'package:app_chiseletor_example/pages/homepage.dart';
import '../l10n/app_localizations.dart';
import 'package:app_chiseletor_example/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/my_custom_theme.dart';
import '../themes/blue_theme.dart';

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
  final providers = await AppInitializer.initialize(
    defaultLocale: const Locale('zh', 'TW'),
    customThemes: [
      MyCustomTheme(),
      BlueTheme(),
    ],
  );

  runApp(
    MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) => const ThemedMaterialApp(
          materialApp: MaterialApp(
            home: AuthWrapper(
              homepage: HomePage(child: DemoContent()),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    ),
  );
}
