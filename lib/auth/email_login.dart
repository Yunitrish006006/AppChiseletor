import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';

class EmailLoginBlock extends StatelessWidget {
  EmailLoginBlock({super.key, required this.authManager});
  final AuthenticationManager authManager;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final email = emailController.text;
            final password = passwordController.text;
            authManager.signInWithEmailAndPassword(email, password);
            Navigator.pop(context);
          },
          child: const Text('Login with Email'),
        ),
      ],
    );
  }
}
