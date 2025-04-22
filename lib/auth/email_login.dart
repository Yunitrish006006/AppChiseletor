import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';

class EmailLoginBlock extends StatefulWidget {
  const EmailLoginBlock({
    super.key,
    required this.authManager,
    required this.onLoginStart,
    required this.onLoginEnd,
  });

  final AuthenticationManager authManager;
  final VoidCallback onLoginStart;
  final VoidCallback onLoginEnd;

  @override
  State<EmailLoginBlock> createState() => _EmailLoginBlockState();
}

class _EmailLoginBlockState extends State<EmailLoginBlock> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  bool isLoggingIn = false;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        emailError = '電子郵件不能為空';
      } else if (!isValidEmail(value)) {
        emailError = '請輸入有效的電子郵件地址';
      } else {
        emailError = null;
      }
    });
  }

  void validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        passwordError = '密碼不能為空';
      } else if (value.length < 6) {
        passwordError = '密碼長度至少需要6個字符';
      } else {
        passwordError = null;
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: '電子郵件',
            errorText: emailError,
          ),
          onChanged: validateEmail,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enableSuggestions: false,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: '密碼',
            errorText: passwordError,
          ),
          obscureText: true,
          onChanged: validatePassword,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: isLoggingIn
              ? null
              : () async {
                  final email = emailController.text;
                  final password = passwordController.text;

                  validateEmail(email);
                  validatePassword(password);

                  if (emailError != null || passwordError != null) {
                    return;
                  }

                  setState(() {
                    isLoggingIn = true;
                  });
                  widget.onLoginStart();

                  try {
                    await widget.authManager
                        .signInWithEmailAndPassword(email, password);
                    if (mounted) {
                      Navigator.of(context).pop();
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
          child: Text(isLoggingIn ? '登入中...' : '使用電子郵件登入'),
        ),
      ],
    );
  }
}
