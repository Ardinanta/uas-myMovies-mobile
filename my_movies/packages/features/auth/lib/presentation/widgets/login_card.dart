import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'login_text_field.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    this.onLogin,
  });

  final VoidCallback? onLogin;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.88),
        borderRadius: AppRadius.lgBorder,
        border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('EMAIL / USERNAME', style: _fieldLabelStyle),
            const SizedBox(height: 8),
            const LoginTextField(
              hintText: 'Enter your account',
              icon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 14),
            Text('PASSWORD', style: _fieldLabelStyle),
            const SizedBox(height: 8),
            const LoginTextField(
              hintText: '********',
              icon: Icons.lock_outline_rounded,
              obscureText: true,
            ),
            const SizedBox(height: 26),
            FilledButton(
              onPressed: onLogin,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: AppColors.cinematicRed,
                foregroundColor: AppColors.white,
                textStyle: AppTextStyles.titleMd.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.regularBorder,
                ),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _fieldLabelStyle => AppTextStyles.labelCaps.copyWith(
    color: AppColors.onSurfaceVariant,
    fontSize: 10,
    letterSpacing: 1,
  );
}
