import 'package:flutter/material.dart';

/// 語言區域提供者，採用單例模式實現全局訪問
class LocaleProviderSingleton extends ChangeNotifier {
  // 單例實例
  static final LocaleProviderSingleton _instance =
      LocaleProviderSingleton._internal();
  // 工廠構造函數，返回單例實例
  factory LocaleProviderSingleton() => _instance;

  // 私有構造函數，防止外部直接創建實例
  LocaleProviderSingleton._internal();

  // 靜態訪問方式
  static LocaleProviderSingleton get instance => _instance;

  // 存儲外部支援的語言區域
  static List<Locale> _externalSupportedLocales = [];

  // 聲明時初始化欄位，提供默認值
  Locale _locale = const Locale('zh', 'TW');

  /// 獲取當前語言區域
  Locale get locale => _locale;

  /// 初始化語言區域提供者
  static void initialize({
    Locale? defaultLocale,
    List<Locale>? externalSupportedLocales,
  }) {
    if (defaultLocale != null) {
      instance._locale = defaultLocale;
    }
    if (externalSupportedLocales != null) {
      _externalSupportedLocales = externalSupportedLocales;
    }
  }

  /// 設置外部支援的語言區域
  static void setExternalSupportedLocales(List<Locale> locales) {
    _externalSupportedLocales = locales;
    instance.notifyListeners();
  }

  /// 設置語言區域
  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }

  /// 獲取所有支援的語言區域
  List<Locale> get supportedLocales {
    final packageLocales = const [
      Locale('zh', 'TW'), // 繁體中文
      Locale('zh'), // 簡體中文
      Locale('en'), // 英文
    ];

    // 如果沒有外部語言，只返回包內語言
    if (_externalSupportedLocales.isEmpty) {
      return packageLocales;
    }

    // 結合包內和外部語言，避免重複
    final Set<String> addedLocales = {};
    final List<Locale> combinedLocales = [];

    // 首先添加包內語言
    for (final locale in packageLocales) {
      final key = '${locale.languageCode}_${locale.countryCode ?? ""}';
      if (!addedLocales.contains(key)) {
        addedLocales.add(key);
        combinedLocales.add(locale);
      }
    }

    // 然後添加外部語言
    for (final locale in _externalSupportedLocales) {
      final key = '${locale.languageCode}_${locale.countryCode ?? ""}';
      if (!addedLocales.contains(key)) {
        addedLocales.add(key);
        combinedLocales.add(locale);
      }
    }

    return combinedLocales;
  }

  /// 根據語言代碼獲取語言區域
  Locale getLocaleFromCode(String code) {
    switch (code) {
      case 'zh-TW':
        return const Locale('zh', 'TW'); // Traditional Chinese
      case 'zh-CN':
        return const Locale('zh'); // Simplified Chinese
      case 'en':
        return const Locale('en');
      default:
        return const Locale('zh', 'TW');
    }
  }
}
