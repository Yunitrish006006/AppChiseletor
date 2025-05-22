import 'package:flutter/material.dart';
import '../l10n/locale_provider_singleton.dart';

/// 提供 AppChiseletor 的配置功能的實用類
class AppChiselatorConfig {
  /// 設置外部支援的語言區域
  ///
  /// 使用此方法可以在運行時動態添加應用程式支援的語言
  ///
  /// 範例:
  /// ```dart
  /// AppChiselatorConfig.setSupportedLocales([
  ///   const Locale('ja'), // 日文
  ///   const Locale('fr'), // 法文
  /// ]);
  /// ```
  static void setSupportedLocales(List<Locale> locales) {
    LocaleProviderSingleton.setExternalSupportedLocales(locales);
  }
}
