import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart';
import 'package:app_chiseletor/l10n/locale_provider.dart';
import 'package:app_chiseletor/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class ThemedMaterialApp extends StatelessWidget {
  final MaterialApp materialApp;

  const ThemedMaterialApp({super.key, required this.materialApp});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeManager, LocaleProvider>(
      builder: (context, themeManager, localeProvider, _) {
        final delegates =
            List.from(materialApp.localizationsDelegates?.toList() ??
                [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ]);

        debugPrint('=================== Delegates Debug ===================');
        debugPrint(
            'Material App Delegates: ${materialApp.localizationsDelegates}');
        debugPrint('Final Delegates List:');
        for (var delegate in delegates) {
          debugPrint('  - ${delegate.runtimeType}');
        }
        debugPrint('===================================================');
        return MaterialApp(
          key: materialApp.key,
          navigatorKey: materialApp.navigatorKey,
          scaffoldMessengerKey: materialApp.scaffoldMessengerKey,
          home: materialApp.home,
          routes: materialApp.routes ?? {},
          initialRoute: materialApp.initialRoute,
          onGenerateRoute: materialApp.onGenerateRoute,
          onUnknownRoute: materialApp.onUnknownRoute,
          navigatorObservers: materialApp.navigatorObservers ?? [],
          title: materialApp.title ?? 'Flutter App',
          // 多國語言支援
          localizationsDelegates:
              List.from(materialApp.localizationsDelegates?.toList() ??
                  [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ]),
          supportedLocales: materialApp.supportedLocales.isEmpty
              ? [
                  const Locale('zh', 'TW'),
                  const Locale('zh'),
                  const Locale('en'),
                ]
              : materialApp.supportedLocales,
          locale: localeProvider.locale,
          theme: themeManager.lightTheme(context),
          darkTheme: themeManager.darkTheme(context),
          themeMode: themeManager.themeMode(context),
        );
      },
    );
  }
}
