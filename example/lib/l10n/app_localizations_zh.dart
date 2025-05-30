// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'AppChiseletor 演示';

  @override
  String get drawerHeader => '抽屉标题';

  @override
  String get home => '首页';

  @override
  String get settings => '设置';

  @override
  String counter(int count) {
    return '计数器：$count';
  }

  @override
  String get increment => '增加';

  @override
  String get toggleVisibility => '切换可见性';

  @override
  String get hiddenContent => '此内容可以隐藏';

  @override
  String get enterName => '输入您的姓名';

  @override
  String get pleaseEnterText => '请输入文本';

  @override
  String get submit => '提交';

  @override
  String hello(String name) {
    return '您好 $name！';
  }

  @override
  String get car => 'Car';

  @override
  String get transit => 'Transit';

  @override
  String get bike => 'Bike';

  @override
  String get addJapaneseLanguage => 'Add Japanese Language';

  @override
  String get languageAdded => 'Language Added';

  @override
  String listItem(int number) {
    return '项目 $number';
  }

  @override
  String listItemDescription(int number) {
    return '项目 $number 的说明';
  }

  @override
  String tappedItem(int number) {
    return '您点击了项目 $number';
  }

  @override
  String get themeDemo => '主题演示';

  @override
  String get authStatus => '认证状态';

  @override
  String loggedInAs(String email) {
    return '已登录为：$email';
  }

  @override
  String get logout => '登出';

  @override
  String get login => '登录';

  @override
  String get loginFirst => '请先登录';

  @override
  String get loginWithGoogle => '使用谷歌账号登录';

  @override
  String get themeBlue => '蓝色主题';

  @override
  String get guest => 'Guest';

  @override
  String get profile => 'Profile';

  @override
  String get about => 'About';

  @override
  String get feedback => 'Feedback';

  @override
  String get help => 'Help';

  @override
  String get notLoggedIn => 'Not logged in';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw(): super('zh_TW');

  @override
  String get appTitle => 'AppChiseletor 示範';

  @override
  String get drawerHeader => '抽屜標題';

  @override
  String get home => '首頁';

  @override
  String get settings => '設定';

  @override
  String counter(int count) {
    return '計數器：$count';
  }

  @override
  String get increment => '增加';

  @override
  String get toggleVisibility => '切換可見性';

  @override
  String get hiddenContent => '此內容可以隱藏';

  @override
  String get enterName => '輸入您的姓名';

  @override
  String get pleaseEnterText => '請輸入文字';

  @override
  String get submit => '提交';

  @override
  String hello(String name) {
    return '您好 $name！';
  }

  @override
  String get car => '汽車';

  @override
  String get transit => '交通';

  @override
  String get bike => '自行車';

  @override
  String listItem(int number) {
    return '項目 $number';
  }

  @override
  String listItemDescription(int number) {
    return '項目 $number 的說明';
  }

  @override
  String tappedItem(int number) {
    return '您點擊了項目 $number';
  }

  @override
  String get themeDemo => '主題示範';

  @override
  String get authStatus => '驗證狀態';

  @override
  String loggedInAs(String email) {
    return '已登入為：$email';
  }

  @override
  String get logout => '登出';

  @override
  String get login => '登入';

  @override
  String get loginFirst => '請先登入';

  @override
  String get loginWithGoogle => '使用 Google 帳號登入';

  @override
  String get themeBlue => '藍色主題';

  @override
  String get guest => '訪客';

  @override
  String get profile => '個人資料';

  @override
  String get about => '關於';

  @override
  String get feedback => '意見反饋';

  @override
  String get help => '幫助';

  @override
  String get notLoggedIn => '尚未登入';
}
