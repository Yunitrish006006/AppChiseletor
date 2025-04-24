import 'package:app_chiseletor/auth/auth_wrapper.dart';
import 'package:app_chiseletor/theme/app_initializer.dart';
import 'package:app_chiseletor/widgets/theme_material_app.dart';
import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart'
    as app_localizations_app;
import '../l10n/app_localizations.dart';
import 'package:app_chiseletor_example/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/my_custom_theme.dart';
import '../themes/blue_theme.dart';

void main() async {
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
        builder: (context) => ThemedMaterialApp(
          materialApp: MaterialApp(
            home: const AuthWrapper(
              homepage: MyHomePage(title: 'Flutter Demo', child: DemoContent()),
            ),
            localizationsDelegates: [
              ...AppLocalizations.localizationsDelegates,
              app_localizations_app.AppLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    ),
  );
}
