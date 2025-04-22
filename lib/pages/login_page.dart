import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/auth/email_login.dart';
import 'package:app_chiseletor/auth/google_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.authManager});
  final AuthenticationManager authManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmailLoginBlock(authManager: authManager),
            const SizedBox(height: 16),
            GoogleLoginBlock(authManager: authManager),
          ],
        ),
      ),
    );
  }
}
