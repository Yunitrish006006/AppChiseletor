import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/auth/email_login.dart';
import 'package:app_chiseletor/auth/google_login.dart';
import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart' as al;
import 'package:app_chiseletor/widgets/language_toggle_button_singleton.dart';
import 'package:app_chiseletor/widgets/theme_selection_button.dart';
import 'package:app_chiseletor/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.authManager});
  final AuthenticationManager authManager;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Widget loadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.blueGrey,
      color: Colors.blue,
      strokeWidth: 12,
      trackGap: 27,
    ),
  );
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
    final l10n = al.AppLocalizations.of(context);
    final theme = Theme.of(context);

    if (l10n == null) {
      return Container(
          color: theme.scaffoldBackgroundColor, child: loadingIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.login),
        actions: const [
          LanguageToggleButtonSingleton(),
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
              child: loadingIndicator(),
            ),
        ],
      ),
    );
  }
}
