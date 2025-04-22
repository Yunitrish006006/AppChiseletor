# AppChiseletor

一個具備主題管理和身份驗證功能的 Flutter 應用程式框架。

## 功能特色

### 主題管理
該應用程式包含一個靈活的主題管理系統，允許輕鬆切換主題和創建自定義主題。

#### 內建主題
- 預設主題 (Default Theme)
- 灰色主題 (Gray Theme)
- 自定義主題 (Custom Theme)

### 身份驗證
支援多種身份驗證方式，透過 Firebase Authentication 實現。

- 電子郵件/密碼登入
- Google 登入
- 身份驗證狀態保持
- 載入狀態指示器

### 多語言支援
- 繁體中文 (zh_TW)
- 簡體中文 (zh)
- 英文 (en)

## 在其他專案中使用

### 方法 1：透過 Git 依賴

在你的 `pubspec.yaml` 中添加：

```yaml
dependencies:
  app_chiseletor:
    git:
      url: https://github.com/Yunitrish006006/AppChiseletor.git
      ref: main  # 或指定版本標籤
```

### 方法 2：本地依賴

1. 複製專案到本地
2. 在你的 `pubspec.yaml` 中添加：

```yaml
dependencies:
  app_chiseletor:
    path: ../AppChiseletor
```

### 使用範例

#### 1. 初始化應用程式

```dart
void main() async {
  final providers = await AppInitializer.initialize(
    customThemes: [MyCustomTheme()],  // 添加自定義主題
    defaultLocale: const Locale('zh', 'TW'),  // 設置預設語言
  );

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}
```

#### 2. 使用主題管理

```dart
// 切換主題
final themeManager = context.read<ThemeManager>();
await themeManager.loadTheme('custom');  // 載入自定義主題

// 切換明暗模式
themeManager.toggleThemeMode(context);
```

#### 3. 使用身份驗證

```dart
// 電子郵件登入
final authManager = context.read<AuthenticationManager>();
await authManager.signInWithEmailAndPassword(email, password);

// Google 登入
await authManager.signInWithGoogle();

// 登出
await authManager.signOut();
```

#### 4. 語言切換

```dart
final localeProvider = context.read<LocaleProvider>();
localeProvider.setLocale(const Locale('en'));  // 切換到英文
```

## 自定義主題指南

### 1. 創建自定義主題類別

創建一個新的 Dart 類別並實現 `ThemeInterface`：

```dart
import 'package:flutter/material.dart';
import 'package:app_chiseletor/theme/theme_interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlueTheme implements ThemeInterface {
  @override
  String get name => 'blue';  // 主題的唯一識別碼

  @override
  String getLocalizedName(BuildContext context) {
    return AppLocalizations.of(context)!.themeBlue;  // 使用本地化字串
  }

  @override
  ThemeData get lightTheme => ThemeData(
    // 淺色主題配置
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    // ... 其他主題設定
  );

  @override
  ThemeData get darkTheme => ThemeData(
    // 深色主題配置
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    // ... 其他主題設定
  );
}
```

### 2. 添加本地化字串

在 `lib/l10n/` 目錄下的各語言檔案中添加主題名稱翻譯：

**app_en.arb** (英文)：
```json
{
  "themeBlue": "Blue Theme",
  "@themeBlue": {
    "description": "Name of the blue theme"
  }
}
```

**app_zh.arb** (簡體中文)：
```json
{
  "themeBlue": "蓝色主题"
}
```

**app_zh_TW.arb** (繁體中文)：
```json
{
  "themeBlue": "藍色主題"
}
```

### 3. 生成本地化檔案

運行以下命令生成本地化支援檔案：
```bash
flutter gen-l10n
```

### 4. 註冊主題

在應用程式的 `main()` 函數中註冊你的自定義主題：

```dart
void main() async {
  final providers = await AppInitializer.initialize(
    customThemes: [
      MyCustomTheme(),  // 你的自定義主題
      BlueTheme(),      // 新添加的藍色主題
    ],
    defaultLocale: const Locale('zh', 'TW'),
  );

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}
```

### 自定義主題細節

你可以自定義主題的多個方面：

1. **基本顏色**
```dart
ThemeData(
  primarySwatch: Colors.blue,    // 主色調
  primaryColor: Colors.blue,     // 主要顏色
  canvasColor: Colors.white,     // 畫布顏色
  scaffoldBackgroundColor: Colors.blue[50],  // 背景顏色
)
```

2. **AppBar 樣式**
```dart
appBarTheme: const AppBarTheme(
  color: Colors.blue,
  foregroundColor: Colors.white,
)
```

3. **按鈕樣式**
```dart
buttonTheme: const ButtonTheme(
  buttonColor: Colors.blue,
  textTheme: ButtonTextTheme.primary,
)
```

4. **文字樣式**
```dart
textTheme: const TextTheme(
  bodyLarge: TextStyle(color: Colors.black87),
  bodyMedium: TextStyle(color: Colors.black54),
)
```

### 使用主題

一旦註冊了自定義主題，用戶可以通過內建的主題選擇按鈕來切換主題：

```dart
AppBar(
  actions: [
    ThemeToggleButton(),      // 明暗模式切換
    ThemeSelectionButton(),   // 主題選擇
    LanguageToggleButton(),   // 語言切換
  ],
)
```

系統會自動處理：
- 主題切換和狀態保持
- 明暗模式切換
- 系統主題跟隨
- 動態 UI 更新

## 必要依賴

請確保你的專案 `pubspec.yaml` 包含以下依賴：

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  google_sign_in: ^6.1.6
  provider: ^6.1.1
```

## 設定說明

### Firebase 設定

1. 在 Firebase Console 創建新專案
2. 下載並添加 Firebase 配置文件：
   - Android: `google-services.json`
   - iOS: `GoogleService-Info.plist`
3. 啟用所需的身份驗證方式（電子郵件/密碼、Google 登入等）

### Google 登入設定

1. 在 Firebase Console 設定 OAuth 2.0 用戶端 ID
2. 設定 Android/iOS 應用程式的 SHA-1 憑證指紋

## 主要組件說明

### 1. ThemedMaterialApp
核心應用程式包裝器，統一管理主題、在地化和路由。
```dart
ThemedMaterialApp(
  home: HomePage(),  // 你的主頁面
)
```

### 2. 主題相關組件

#### ThemeToggleButton
快速切換明暗模式的按鈕組件。通常放置在 AppBar 的 actions 中：
```dart
AppBar(
  actions: [
    ThemeToggleButton(),
  ],
)
```

#### ThemeSelectionButton
用於選擇不同主題的按鈕組件。支援所有已註冊的主題：
- 預設主題 (Default Theme)
- 灰色主題 (Gray Theme)
- 自定義主題 (Custom Theme)

### 3. 語言相關組件

#### LanguageToggleButton
快速切換應用程式語言的按鈕組件。支援：
- 繁體中文 (zh_TW)
- 簡體中文 (zh)
- 英文 (en)

通常與主題切換按鈕一起放在 AppBar：
```dart
AppBar(
  actions: [
    LanguageToggleButton(),
    ThemeToggleButton(),
  ],
)
```

### 4. 身份驗證組件

#### AuthButton
整合式的身份驗證按鈕，提供：
- 登入/登出切換
- 登入方式選擇對話框
- 電子郵件登入表單
- Google 登入整合
- 載入狀態指示

使用方式：
```dart
AppBar(
  actions: [
    AuthButton(),  // 將自動處理所有身份驗證相關邏輯
  ],
)
```

#### EmailLoginBlock
單獨的電子郵件登入表單組件，可用於自定義登入界面：
```dart
EmailLoginBlock(
  authManager: authManager,
  onLoginStart: () => setState(() => _isLoading = true),
  onLoginEnd: () => setState(() => _isLoading = false),
)
```

#### GoogleLoginBlock
單獨的 Google 登入按鈕組件：
```dart
GoogleLoginBlock(
  authManager: authManager,
  onLoginStart: () => setState(() => _isLoading = true),
  onLoginEnd: () => setState(() => _isLoading = false),
)
```

### 5. 狀態管理

本框架使用 Provider 作為狀態管理解決方案，主要提供以下 Provider：

#### ThemeManager
管理應用程式主題相關狀態：
```dart
final themeManager = context.read<ThemeManager>();
// 切換主題
await themeManager.loadTheme('gray');  // 切換到灰色主題
// 切換明暗模式
themeManager.toggleThemeMode();
```

#### LocaleProvider
管理應用程式語言相關狀態：
```dart
final localeProvider = context.read<LocaleProvider>();
// 切換語言
localeProvider.setLocale(const Locale('en'));
```

#### AuthenticationManager
管理身份驗證相關狀態：
```dart
final authManager = context.read<AuthenticationManager>();
// 檢查登入狀態
if (authManager.isLoggedIn) {
  // 已登入的處理邏輯
}
```

## 貢獻指南

歡迎提交 Pull Requests 來改善這個專案！
