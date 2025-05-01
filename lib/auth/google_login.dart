import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart';

class GoogleLoginBlock extends StatefulWidget {
  const GoogleLoginBlock({
    super.key,
    required this.authManager,
    required this.onLoginStart,
    required this.onLoginEnd,
  });

  final AuthenticationManager authManager;
  final VoidCallback onLoginStart;
  final VoidCallback onLoginEnd;

  @override
  State<GoogleLoginBlock> createState() => _GoogleLoginBlockState();
}

class _GoogleLoginBlockState extends State<GoogleLoginBlock> {
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ElevatedButton(
      onPressed: isLoggingIn
          ? null
          : () async {
              setState(() {
                isLoggingIn = true;
              });
              widget.onLoginStart();

              try {
                await widget.authManager.signInWithGoogle();
                if (mounted && Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              } finally {
                if (mounted) {
                  setState(() {
                    isLoggingIn = false;
                  });
                  widget.onLoginEnd();
                }
              }
            },
      child: Text(isLoggingIn ? l10n.loggingIn : l10n.loginWithGoogle),
    );
  }
}
