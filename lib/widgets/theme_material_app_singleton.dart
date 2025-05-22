import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart';
import 'package:app_chiseletor/l10n/locale_provider_singleton.dart';
import 'package:app_chiseletor/theme/theme_manager_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// 使用單例模式的主題管理器的 MaterialApp
class ThemedMaterialAppSingleton extends StatelessWidget {
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
  final Key? key;

  const ThemedMaterialAppSingleton({
    this.key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.builder,
    this.title,
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
    // 直接使用單例獲取主題管理器
    final themeManager = ThemeManagerSingleton.instance;
    // 直接使用單例獲取語言提供者
    final localeProvider = LocaleProviderSingleton.instance;

    // 使用AnimatedBuilder來監聽themeManager的變化
    return AnimatedBuilder(
      animation:
          themeManager, // 由於ThemeManagerSingleton繼承自ChangeNotifier，可以作為animation參數
      builder: (context, _) {
        // 同時使用AnimatedBuilder監聽localeProvider的變化
        return AnimatedBuilder(
          animation: localeProvider,
          builder: (context, _) {
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
              onGenerateInitialRoutes: onGenerateInitialRoutes,
              onUnknownRoute: onUnknownRoute,
              navigatorObservers:
                  navigatorObservers ?? const <NavigatorObserver>[],
              builder: builder,
              title: title ?? '',
              color: color, // 应用主题和本地化设置 - 使用無需 context 的單例方法
              theme: themeManager.lightTheme(),
              darkTheme: themeManager.darkTheme(),
              themeMode: themeManager.themeMode(),
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
      },
    );
  }
}
