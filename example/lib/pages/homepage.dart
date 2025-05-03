import 'package:app_chiseletor/auth/auth_button.dart';
import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/auth/email_login.dart';
import 'package:app_chiseletor/widgets/language_toggle_button.dart';
import 'package:app_chiseletor/widgets/theme_selection_button.dart';
import 'package:app_chiseletor/widgets/theme_toggle_button.dart';
import 'package:app_chiseletor/widgets/user_drawer.dart';
import 'package:app_chiseletor_example/pages/user_list_sample.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.child});
  final Widget child;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleProfileTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('個人資料頁面')),
    );
  }

  void _handleSettingsTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('設定頁面')),
    );
  }

  void _handleAboutTap() {
    showAboutDialog(
      context: context,
      applicationName: 'AppChiseletor Demo',
      applicationVersion: '1.1.5+7',
      applicationLegalese: '© 2025 AppChiseletor',
    );
  }

  void _handleFeedbackTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('意見反饋頁面')),
    );
  }

  void _handleHelpTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('幫助頁面')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: const [
          ThemeToggleButton(),
          ThemeSelectionButton(),
          LanguageToggleButton(),
          AuthButton(),
        ],
      ),
      drawer: UserDrawer(
        onProfileTap: _handleProfileTap,
        onSettingsTap: _handleSettingsTap,
        onAboutTap: _handleAboutTap,
        onFeedbackTap: _handleFeedbackTap,
        onHelpTap: _handleHelpTap,
        onHomeTap: () {
          // 如果已經在首頁，只需關閉抽屜
          Navigator.pop(context);
        },
        additionalItems: [
          // 用戶列表範例頁面
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('用戶列表範例'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserListSample()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.emoji_transportation),
            title: Text(l10n.transit),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('交通頁面')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: Text(l10n.car),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('汽車頁面')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_bike),
            title: Text(l10n.bike),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('自行車頁面')),
              );
            },
          ),
        ],
      ),
      body: widget.child,
    );
  }
}

Widget cc(BuildContext context) {
  final authManager = context.watch<AuthenticationManager>();
  final l10n = AppLocalizations.of(context)!;
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  l10n.themeDemo,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                const ThemeSelectionButton(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  l10n.authStatus,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                if (authManager.currentUser != null) ...[
                  Text(l10n.loggedInAs(authManager.currentUser?.email ?? '')),
                  ElevatedButton(
                    onPressed: () => authManager.signOut(),
                    child: Text(l10n.logout),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: () => {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(l10n.loginFirst),
                          content: EmailLoginBlock(
                            authManager: authManager,
                            onLoginStart: () => {},
                            onLoginEnd: () => {},
                          ),
                        ),
                      )
                    },
                    child: Text(l10n.login),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => authManager.signInWithGoogle(),
                    child: Text(l10n.loginWithGoogle),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
