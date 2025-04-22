# AppChiseletor

A Flutter application with theme management and authentication features.

## Features

### Theme Management
The app includes a flexible theme management system that allows for easy theme switching and custom theme creation.

#### Available Themes
- Default Theme
- Gray Theme
- Custom Theme

#### How to Add a New Theme
1. Create a new theme class in the `lib/plugins` directory implementing `ThemeInterface`:
```dart
class MyNewTheme implements ThemeInterface {
  @override
  String get name => 'my_new_theme';

  @override
  ThemeData get themeData => ThemeData(
    // Define your theme properties here
  );
}
```

2. Register your theme in `main.dart`:
```dart
void main() async {
  final themeManager = ThemeManager();
  // Register your new theme
  themeManager.registerPluginTheme(MyNewTheme());
}
```

### Authentication
The app supports multiple authentication methods through Firebase Authentication.

#### Features
- Email/Password login
- Google Sign-in
- Authentication state persistence
- Loading state indicators during authentication

#### How to Use Authentication
1. Email/Password Login:
```dart
final authManager = context.read<AuthenticationManager>();
await authManager.signInWithEmailAndPassword(email, password);
```

2. Google Sign-in:
```dart
final authManager = context.read<AuthenticationManager>();
await authManager.signInWithGoogle();
```

3. Sign Out:
```dart
final authManager = context.read<AuthenticationManager>();
await authManager.signOut();
```

### Available Widgets

#### AuthButton
A button that handles authentication state and shows login/logout options.
```dart
AppBar(
  actions: [
    AuthButton(),
  ],
)
```

#### ThemeToggleButton
A button that allows users to switch between available themes.
```dart
AppBar(
  actions: [
    ThemeToggleButton(),
  ],
)
```

#### AuthWrapper
A widget that wraps your app and handles authentication state management.
```dart
AuthWrapper(
  homepage: MyHomePage(title: 'Home Page'),
)
```

## Project Structure
```
lib/
  ├── auth/           # Authentication related files
  ├── l10n/           # Localization
  ├── pages/          # App pages
  ├── plugins/        # Theme plugins
  ├── theme/          # Theme management
  └── widgets/        # Reusable widgets
```

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase project setup
- Google Sign-in configuration

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure Firebase:
   - Add your `google-services.json` for Android
   - Set up Firebase configuration in `lib/firebase_options.dart`
4. Run the app: `flutter run`

## Contributing
Feel free to submit issues and enhancement requests.
