import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'login_text_field.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
    required this.onGuestLogin,
    this.isLoading = false,
    this.errorMessage,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onGuestLogin;
  final bool isLoading;
  final String? errorMessage;

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
            Text('USERNAME', style: _fieldLabelStyle),
            const SizedBox(height: 8),
            LoginTextField(
              controller: usernameController,
              hintText: 'Enter your account',
              icon: Icons.person_outline_rounded,
              enabled: !isLoading,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 14),
            Text('PASSWORD', style: _fieldLabelStyle),
            const SizedBox(height: 8),
            LoginTextField(
              controller: passwordController,
              hintText: '********',
              icon: Icons.lock_outline_rounded,
              obscureText: true,
              enabled: !isLoading,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => isLoading ? null : onLogin(),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 14),
              Text(
                errorMessage!,
                style: AppTextStyles.bodySm.copyWith(
                  color: AppColors.cinematicRed,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
            const SizedBox(height: 26),
            FilledButton(
              onPressed: isLoading ? null : onLogin,
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
              child: isLoading
                  ? const SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: AppColors.white,
                      ),
                    )
                  : const Text('Login'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: isLoading ? null : onGuestLogin,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: AppColors.white,
                side: BorderSide(
                  color: AppColors.white.withValues(alpha: 0.14),
                ),
                textStyle: AppTextStyles.titleMd.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.regularBorder,
                ),
              ),
              child: const Text('Login sebagai Guest'),
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
