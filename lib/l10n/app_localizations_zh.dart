// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '首頁';

  @override
  String get buttonPushCount => '你已經按了這個按鈕這麼多次：';

  @override
  String get increment => '增加';

  @override
  String get login => '登入';

  @override
  String get logout => '登出';

  @override
  String get email => '電子郵件';

  @override
  String get password => '密碼';

  @override
  String get loginWithEmail => '使用電子郵件登入';

  @override
  String get loginWithGoogle => '使用 Google 登入';

  @override
  String get cancel => '取消';

  @override
  String get emailEmpty => '電子郵件不能為空';

  @override
  String get emailInvalid => '請輸入有效的電子郵件地址';

  @override
  String get passwordEmpty => '密碼不能為空';

  @override
  String get passwordTooShort => '密碼長度至少需要6個字符';

  @override
  String get loggingIn => '登入中...';

  @override
  String get themeDefault => '预设主题';

  @override
  String get themeGray => '灰色主题';

  @override
  String get themeCustom => '自定义主题';

  @override
  String get themeModeSystem => '系统主题';

  @override
  String get themeModeLight => '浅色主题';

  @override
  String get themeModeDark => '深色主题';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw(): super('zh_TW');

  @override
  String get appTitle => '首頁';

  @override
  String get buttonPushCount => '你已經按了這個按鈕這麼多次：';

  @override
  String get increment => '增加';

  @override
  String get login => '登入';

  @override
  String get logout => '登出';

  @override
  String get email => '電子郵件';

  @override
  String get password => '密碼';

  @override
  String get loginWithEmail => '使用電子郵件登入';

  @override
  String get loginWithGoogle => '使用 Google 登入';

  @override
  String get cancel => '取消';

  @override
  String get emailEmpty => '電子郵件不能為空';

  @override
  String get emailInvalid => '請輸入有效的電子郵件地址';

  @override
  String get passwordEmpty => '密碼不能為空';

  @override
  String get passwordTooShort => '密碼長度至少需要6個字符';

  @override
  String get loggingIn => '登入中...';

  @override
  String get themeDefault => '預設主題';

  @override
  String get themeGray => '灰色主題';

  @override
  String get themeCustom => '自訂主題';

  @override
  String get themeModeSystem => '系統主題';

  @override
  String get themeModeLight => '淺色主題';

  @override
  String get themeModeDark => '深色主題';
}
