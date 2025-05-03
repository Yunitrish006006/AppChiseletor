// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AppChiseletor Demo';

  @override
  String get drawerHeader => 'Drawer Header';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String counter(int count) {
    return 'Counter: $count';
  }

  @override
  String get increment => 'Increment';

  @override
  String get toggleVisibility => 'Toggle Visibility';

  @override
  String get hiddenContent => 'This content can be hidden';

  @override
  String get enterName => 'Enter your name';

  @override
  String get pleaseEnterText => 'Please enter some text';

  @override
  String get submit => 'Submit';

  @override
  String hello(String name) {
    return 'Hello $name!';
  }

  @override
  String listItem(int number) {
    return 'Item $number';
  }

  @override
  String listItemDescription(int number) {
    return 'Description for item $number';
  }

  @override
  String tappedItem(int number) {
    return 'You tapped item $number';
  }

  @override
  String get themeDemo => 'Theme Demo';

  @override
  String get authStatus => 'Authentication Status';

  @override
  String loggedInAs(String email) {
    return 'Logged in as: $email';
  }

  @override
  String get logout => 'Logout';

  @override
  String get login => 'Login';

  @override
  String get loginFirst => 'Please login first';

  @override
  String get loginWithGoogle => 'Login with Google';

  @override
  String get themeBlue => 'Blue Theme';

  @override
  String get car => 'Car';

  @override
  String get transit => 'Transit';

  @override
  String get bike => 'Bike';

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
