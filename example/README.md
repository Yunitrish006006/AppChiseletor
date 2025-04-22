# AppChiseletor Example

這個示例專案展示了如何使用 AppChiseletor 套件的主要功能。

## 功能展示

1. 主題管理
   - 切換預設主題和灰色主題
   - 深色/淺色模式切換
   - 主題持久化儲存

2. 身份驗證
   - 電子郵件登入
   - Google 帳號登入
   - 登入狀態持久化

3. 多語言支援
   - 英文 (en)
   - 簡體中文 (zh)
   - 繁體中文 (zh_TW)

## 開始使用

1. 設置 Firebase
   - 在 Firebase Console 創建新專案
   - 下載並設置設定檔：
     - Android: 將 `google-services.json` 放在 `android/app/` 目錄
     - iOS: 將 `GoogleService-Info.plist` 放在 `ios/Runner/` 目錄
   - 更新 `lib/firebase_options.dart` 中的設定值

2. 安裝依賴
   ```bash
   flutter pub get
   ```

3. 運行專案
   ```bash
   flutter run
   ```

## 程式碼說明

- `lib/main.dart`: 主要的應用程式邏輯和 UI 實現
- `lib/firebase_options.dart`: Firebase 設定檔

## 注意事項

1. 此專案僅供展示用途，請在實際使用時更換為您自己的 Firebase 設定。
2. 請確保您的 Firebase 專案已啟用所需的身份驗證方式。
3. 在運行專案前，請確保已完成所有必要的設定。
