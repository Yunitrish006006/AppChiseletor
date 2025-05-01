import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart';
import 'package:app_chiseletor/l10n/locale_provider.dart';
import 'package:app_chiseletor/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// Instead of extending MaterialApp, create a StatelessWidget that returns a themed MaterialApp
class ThemedMaterialApp extends StatelessWidget {
  final String? title;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final Color? color;
  final bool debugShowCheckedModeBanner;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowMaterialGrid;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final Iterable<Locale> supportedLocales;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  const ThemedMaterialApp({
    super.key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.onGenerateInitialRoutes,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = 'Flutter App',
    this.color,
    this.debugShowCheckedModeBanner = true,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowMaterialGrid = false,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.supportedLocales = const <Locale>[Locale('en')],
    this.localizationsDelegates,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeManager, LocaleProvider>(
      builder: (context, themeManager, localeProvider, _) {
        // 构建本地化代理列表
        final delegates = <LocalizationsDelegate<dynamic>>[
          if (localizationsDelegates != null) ...localizationsDelegates!,
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ];

        // 创建MaterialApp，应用主题和本地化设置
        return MaterialApp(
          key: key,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          home: home,
          routes: routes ?? const {},
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          onGenerateInitialRoutes: onGenerateInitialRoutes,
          navigatorObservers: navigatorObservers ?? const [],
          builder: builder,
          title: title ?? 'Flutter App',
          color: color,

          // 应用主题和本地化设置
          theme: themeManager.lightTheme(context),
          darkTheme: themeManager.darkTheme(context),
          themeMode: themeManager.themeMode(context),
          localizationsDelegates: delegates,
          supportedLocales: supportedLocales.isEmpty
              ? AppLocalizations.supportedLocales
              : supportedLocales,
          locale: localeProvider.locale,

          // 其他属性
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          showPerformanceOverlay: showPerformanceOverlay,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          showSemanticsDebugger: showSemanticsDebugger,
          debugShowMaterialGrid: debugShowMaterialGrid,
          shortcuts: shortcuts,
          actions: actions,
          restorationScopeId: restorationScopeId,
          scrollBehavior: scrollBehavior,
        );
      },
    );
  }
}
