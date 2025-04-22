// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Home';

  @override
  String get buttonPushCount => 'You have pushed the button this many times:';

  @override
  String get increment => 'Increment';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get loginWithEmail => 'Login with Email';

  @override
  String get loginWithGoogle => 'Login with Google';

  @override
  String get cancel => 'Cancel';

  @override
  String get emailEmpty => 'Email cannot be empty';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get passwordEmpty => 'Password cannot be empty';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get loggingIn => 'Logging in...';

  @override
  String get themeDefault => 'Default Theme';

  @override
  String get themeGray => 'Gray Theme';

  @override
  String get themeCustom => 'Custom Theme';

  @override
  String get themeBlue => 'Blue Theme';

  @override
  String get themeModeSystem => 'System Theme';

  @override
  String get themeModeLight => 'Light Theme';

  @override
  String get themeModeDark => 'Dark Theme';
}
