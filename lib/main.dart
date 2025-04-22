import 'package:app_chiseletor/home_page.dart';
import 'package:app_chiseletor/plugins/gray_theme.dart';
import 'package:app_chiseletor/widgets/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme_manager.dart';
import 'auth/auth_manager.dart';
import 'plugins/my_custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final themeManager = ThemeManager();
  await themeManager.loadTheme('default');

  themeManager.registerPluginTheme(MyCustomTheme());
  themeManager.registerPluginTheme(GrayTheme());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeManager),
        ChangeNotifierProvider(create: (_) => AuthenticationManager()),
      ],
      //  直接使用 ThemedMaterialApp
      child: AuthWrapper(homepage: const MyHomePage(title: 'Home Page')),
    ),
  );
}
