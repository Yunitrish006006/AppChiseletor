# Contributing to AppChiseletor

我們非常歡迎並感謝您對 AppChiseletor 專案的貢獻！本文件將指導您如何參與貢獻。

## 開發流程

1. Fork 此專案到您的 GitHub 帳戶
2. 將您的 Fork clone 到本地：
   ```bash
   git clone https://github.com/YOUR_USERNAME/AppChiseletor.git
   ```
3. 建立新的分支：
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 環境設置

1. 確保您已安裝：
   - Flutter SDK (3.0.0 或以上)
   - Dart SDK (3.1.3 或以上)
   - Android Studio 或 VS Code

2. 安裝依賴：
   ```bash
   flutter pub get
   ```

3. 設置 Firebase：
   - 在 Firebase Console 建立新專案
   - 下載並添加設定檔：
     - Android: `google-services.json`
     - iOS: `GoogleService-Info.plist`

## 程式碼風格指南

- 遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 風格指南
- 使用 `flutter format .` 格式化程式碼
- 確保程式碼通過 `flutter analyze` 檢查

## 提交變更

1. 確保您的變更有適當的測試覆蓋
2. 更新文檔以反映您的變更
3. 提交您的變更：
   ```bash
   git commit -m "feat: 新增功能描述"
   ```
4. 推送到您的 Fork：
   ```bash
   git push origin feature/your-feature-name
   ```
5. 建立 Pull Request

## Commit 訊息規範

我們使用 [Conventional Commits](https://www.conventionalcommits.org/) 規範：

- `feat:` 新功能
- `fix:` Bug 修復
- `docs:` 文檔更新
- `style:` 程式碼格式（不影響程式碼運行的變動）
- `refactor:` 重構（即不是新增功能，也不是修改 bug 的程式碼變動）
- `test:` 新增測試
- `chore:` 構建過程或輔助工具的變動

## 問題回報

- 使用 GitHub Issues 回報問題
- 清楚描述問題，包含重現步驟
- 附上相關的錯誤訊息和 log
- 說明使用的環境（Flutter 版本、作業系統等）

## 行為準則

- 保持友善和專業的態度
- 尊重其他貢獻者
- 接受建設性的批評和建議

感謝您的貢獻！