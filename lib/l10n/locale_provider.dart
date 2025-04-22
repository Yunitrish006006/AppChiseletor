import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  // 將預設語言改為繁體中文
  Locale _locale = const Locale('zh', 'TW');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}
