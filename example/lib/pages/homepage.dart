import 'package:app_chiseletor/auth/auth_button.dart';
import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/auth/email_login.dart';
import 'package:app_chiseletor/widgets/language_toggle_button.dart';
import 'package:app_chiseletor/widgets/theme_selection_button.dart';
import 'package:app_chiseletor/widgets/theme_toggle_button.dart';
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.primaryColor,
              ),
              child: Text(
                l10n.drawerHeader,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(l10n.home),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(l10n.settings),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
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
