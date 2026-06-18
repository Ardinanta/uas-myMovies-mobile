import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'MYMOVIES',
          style: AppTextStyles.titleMd.copyWith(
            color: AppColors.cinematicRed,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'CURATED CINEMA EXPLORER',
          style: AppTextStyles.labelCaps.copyWith(
            color: AppColors.onSurface,
            letterSpacing: 3,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
