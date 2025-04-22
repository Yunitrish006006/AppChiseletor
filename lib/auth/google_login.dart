import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoogleLoginBlock extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ElevatedButton(
      onPressed: () async {
        onLoginStart();
        await authManager.signInWithGoogle();
        onLoginEnd();
        if (context.mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Text(l10n.loginWithGoogle),
    );
  }
}
