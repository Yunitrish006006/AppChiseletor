import 'package:app_chiseletor/l10n/locale_provider.dart';
import 'package:app_chiseletor/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app_chiseletor/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemedMaterialApp extends StatelessWidget {
  final Widget home;
  final localization;

  const ThemedMaterialApp({super.key, required this.home, this.localization});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeManager, LocaleProvider>(
      builder: (context, themeManager, localeProvider, _) {
        return MaterialApp(
          title: 'Flutter App',
          theme: themeManager.lightTheme(context),
          darkTheme: themeManager.darkTheme(context),
          themeMode: themeManager.themeMode(context),

          // 多國語言支援
          localizationsDelegates: [
            localization,
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'TW'), // 繁體中文優先
            Locale('zh'), // 簡體中文
            Locale('en'), // 英文
          ],
          locale: localeProvider.locale,

          home: home,
        );
      },
    );
  }
}
