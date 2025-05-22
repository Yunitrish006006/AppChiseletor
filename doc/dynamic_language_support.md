# 動態語言支援文檔

AppChiseletor 現在支援動態語言加載功能，允許您在應用程式中根據需要添加和顯示不同的語言選項。

## 基本用法

1. 初始化應用程式時，您可以提供外部支援的語言：

```dart
import 'package:app_chiseletor/app_chiseletor.dart';
import 'package:flutter/material.dart';

void main() async {
  // 初始化應用程序
  final providers = await AppInitializerSingleton.initialize(
    defaultLocale: const Locale('zh', 'TW'),
    externalSupportedLocales: [
      const Locale('ja'), // 日文
      const Locale('fr'), // 法文
      const Locale('es'), // 西班牙文
    ],
  );
  
  // 其餘的啟動代碼...
}
```

2. 如果您想在應用程式啟動後設置外部支援的語言，可以使用 `AppChiselatorConfig` 類：

```dart
import 'package:app_chiseletor/app_chiseletor.dart';
import 'package:flutter/material.dart';

void someFunction() {
  // 設置外部支援的語言
  AppChiselatorConfig.setSupportedLocales([
    const Locale('ja'), // 日文
    const Locale('fr'), // 法文
    const Locale('es'), // 西班牙文
  ]);
}
```

3. 同時，您需要在您的應用程式中確保您已經為這些語言提供了本地化資源。

## 在外部應用程式中新增語言的步驟

1. 在外部應用程式的 `l10n.yaml` 檔案中配置您的語言：

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

2. 創建對應語言的 `.arb` 檔案，例如 `app_ja.arb`、`app_fr.arb` 等。

3. 在 `pubspec.yaml` 中添加本地化依賴：

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.0
```

4. 在 `MaterialApp` 中設置本地化代理和支援的語言：

```dart
return MaterialApp(
  // ...
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  // ...
);
```

5. 在啟動應用程式時，告訴 AppChiseletor 您的應用程式支援哪些語言：

```dart
final providers = await AppInitializerSingleton.initialize(
  defaultLocale: const Locale('zh', 'TW'),
  externalSupportedLocales: AppLocalizations.supportedLocales, // 使用您的應用程式的支援語言
);
```

## 技術細節

`AppChiseletor` 使用以下類來支援動態語言：

1. `LocaleProviderSingleton` - 存儲和管理應用程式的語言設置。
2. `LanguageToggleButtonSingleton` - 提供一個 UI 元件，允許用戶在可用的語言之間切換。
3. `AppChiselatorConfig` - 提供一個公共 API，用於在運行時設置外部支援的語言。

這個功能透過結合 Flutter 的本地化系統和自定義的語言管理來實現，確保應用程式可以動態添加和切換語言，而不需要重新構建應用程式。