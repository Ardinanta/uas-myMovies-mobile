import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.textInputAction,
    this.onSubmitted,
  });

  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscureText;
  final bool enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurface),
      cursorColor: AppColors.cinematicRed,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.mutedSilver, size: 22),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
      ),
    );
  }
}
