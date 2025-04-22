import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/theme/app_initializer.dart';
import 'package:app_chiseletor/auth/email_login.dart';
import 'package:app_chiseletor/widgets/theme_material_app.dart';
import 'package:app_chiseletor/widgets/theme_toggle_button.dart';
import 'package:app_chiseletor/widgets/theme_selection_button.dart';
import 'package:app_chiseletor_example/themes/my_custom_theme.dart';
import 'package:app_chiseletor_example/themes/blue_theme.dart'; // 引入新的藍色主題
import 'package:app_chiseletor/widgets/language_toggle_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 初始化應用程式並獲取 providers，註冊多個主題
  final providers = await AppInitializer.initialize(
    defaultLocale: const Locale('zh', 'TW'),
    customThemes: [
      MyCustomTheme(),
      BlueTheme(), // 添加藍色主題
    ],
  );

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ThemedMaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authManager = context.watch<AuthenticationManager>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AppChiseletor Demo'),
        actions: const [
          ThemeToggleButton(),
          ThemeSelectionButton(),
          LanguageToggleButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 主題展示區域
            const Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '主題展示',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 16),
                    ThemeSelectionButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 身份驗證狀態展示
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      '身份驗證狀態',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    if (authManager.currentUser != null) ...[
                      Text('已登入: ${authManager.currentUser?.email}'),
                      ElevatedButton(
                        onPressed: () => authManager.signOut(),
                        child: const Text('登出'),
                      ),
                    ] else ...[
                      ElevatedButton(
                        onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('請先登入'),
                              content: EmailLoginBlock(
                                authManager: authManager,
                                onLoginStart: () => {},
                                onLoginEnd: () => {},
                              ),
                            ),
                          )
                        },
                        child: const Text('登入'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => authManager.signInWithGoogle(),
                        child: const Text('使用 Google 登入'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
