import 'package:app_chiseletor/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme_manager.dart'; // Import the ThemeManager class
import 'auth/auth_manager.dart';
import 'firebase_options.dart';
import 'plugins/my_custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize ThemeManager with a default theme
  final themeManager = ThemeManager();
  await themeManager.loadTheme('default');

  themeManager.registerPluginTheme(MyCustomTheme());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeManager),
        ChangeNotifierProvider(
          create: (_) => AuthenticationManager(),
        ), // Provide AuthenticationManager
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeManager.applyTheme(context),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
