import 'package:app_chiseletor/auth/email_login.dart';
import 'package:app_chiseletor/auth/google_login.dart';
import 'package:app_chiseletor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_manager.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({super.key});

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<AuthenticationManager>(
      builder: (context, authManager, child) {
        return authManager.isLoggedIn
            ? ElevatedButton(
                onPressed: () {
                  authManager.signOut();
                },
                child: Text(l10n.logout),
              )
            : ElevatedButton(
                onPressed: () {
                  _showLoginDialog(context, authManager);
                },
                child: Text(l10n.login),
              );
      },
    );
  }

  void _showLoginDialog(
    BuildContext context,
    AuthenticationManager authManager,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(l10n.login),
              content: _isLoading
                  ? const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EmailLoginBlock(
                          authManager: authManager,
                          onLoginStart: () => setState(() => _isLoading = true),
                          onLoginEnd: () => setState(() => _isLoading = false),
                        ),
                        const SizedBox(height: 16),
                        GoogleLoginBlock(
                          authManager: authManager,
                          onLoginStart: () => setState(() => _isLoading = true),
                          onLoginEnd: () => setState(() => _isLoading = false),
                        ),
                      ],
                    ),
              actions: [
                if (!_isLoading)
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
