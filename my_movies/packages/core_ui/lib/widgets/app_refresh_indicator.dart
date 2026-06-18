import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppRefreshIndicator extends StatelessWidget {
  const AppRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final RefreshCallback onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.cinematicRed,
      backgroundColor: AppColors.surfaceContainerHigh,
      displacement: 28,
      edgeOffset: 8,
      child: child,
    );
  }
}
