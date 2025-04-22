import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  final Widget? homepage;
  const AuthWrapper({super.key, this.homepage});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationManager>(
      builder: (context, authManager, child) {
        if (!authManager.isInitialized) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return authManager.isLoggedIn
            ? widget.homepage ?? const Text("No Home Page Assigned")
            : LoginPage(authManager: authManager);
      },
    );
  }
}
