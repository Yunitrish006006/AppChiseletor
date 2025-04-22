import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/auth/email_login.dart';
import 'package:app_chiseletor/auth/google_login.dart';
import 'package:app_chiseletor/widgets/language_toggle_button.dart';
import 'package:app_chiseletor/widgets/theme_selection_button.dart';
import 'package:app_chiseletor/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:app_chiseletor/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.authManager});
  final AuthenticationManager authManager;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  void _handleLoginStart() {
    setState(() => _isLoading = true);
  }

  void _handleLoginEnd() {
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.login),
        actions: const [
          LanguageToggleButton(),
          ThemeToggleButton(),
          ThemeSelectionButton(),
        ],
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EmailLoginBlock(
                  authManager: widget.authManager,
                  onLoginStart: _handleLoginStart,
                  onLoginEnd: _handleLoginEnd,
                ),
                const SizedBox(height: 16),
                GoogleLoginBlock(
                  authManager: widget.authManager,
                  onLoginStart: _handleLoginStart,
                  onLoginEnd: _handleLoginEnd,
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withAlpha(128),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
