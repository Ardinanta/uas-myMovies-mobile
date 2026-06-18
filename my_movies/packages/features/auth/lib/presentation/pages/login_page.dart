import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../widgets/login_backdrop.dart';
import '../widgets/login_card.dart';
import '../widgets/login_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    this.onLogin,
  });

  final VoidCallback? onLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const LoginBackdrop(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.containerMargin,
                  vertical: 32,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LoginHeader(),
                      const SizedBox(height: 28),
                      LoginCard(onLogin: onLogin),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
