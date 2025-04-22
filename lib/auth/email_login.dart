import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailLoginBlock extends StatelessWidget {
  EmailLoginBlock({
    super.key,
    required this.authManager,
    required this.onLoginStart,
    required this.onLoginEnd,
  });

  final AuthenticationManager authManager;
  final VoidCallback onLoginStart;
  final VoidCallback onLoginEnd;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: l10n.email),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: l10n.password),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            onLoginStart();
            final email = emailController.text;
            final password = passwordController.text;
            await authManager.signInWithEmailAndPassword(email, password);
            onLoginEnd();
            if (context.mounted) Navigator.pop(context);
          },
          child: Text(l10n.loginWithEmail),
        ),
      ],
    );
  }
}
