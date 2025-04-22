import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/pages/login_page.dart';
import 'package:app_chiseletor/widgets/theme_material_app.dart';
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
  void initState() {
    super.initState();
    Provider.of<AuthenticationManager>(
      context,
      listen: false,
    ).addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    // 在 dispose 中取消訂閱
    Provider.of<AuthenticationManager>(
      context,
      listen: false,
    ).removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authManager = Provider.of<AuthenticationManager>(context);
    return ThemedMaterialApp(
      home:
          authManager.isLoggedIn
              ? widget.homepage ?? Text("No Home Page Assigned")
              : const LoginPage(),
    );
  }
}
