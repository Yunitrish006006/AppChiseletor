import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      if (value.isEmpty) {
        emailError = l10n.emailEmpty;
      } else if (!isValidEmail(value)) {
        emailError = l10n.emailInvalid;
      } else {
        emailError = null;
      }
    });
  }

  void validatePassword(String value) {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      if (value.isEmpty) {
        passwordError = l10n.passwordEmpty;
      } else if (value.length < 6) {
        passwordError = l10n.passwordTooShort;
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
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: l10n.email,
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
            labelText: l10n.password,
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
          child: Text(isLoggingIn ? l10n.loggingIn : l10n.loginWithEmail),
        ),
      ],
    );
  }
}
