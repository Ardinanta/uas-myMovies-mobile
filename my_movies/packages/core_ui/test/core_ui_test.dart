import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:core_ui/core_ui.dart';

void main() {
  test('exposes Cinematic Noir design tokens', () {
    expect(AppColors.cinematicRed.toARGB32(), 0xffe50914);
    expect(AppColors.gold.toARGB32(), 0xffffc107);
    expect(AppRadius.lg, 16);
    expect(AppSpacing.containerMargin, 20);
  });

  test('builds dark app theme', () {
    final theme = AppTheme.dark;

    expect(theme.brightness, Brightness.dark);
    expect(theme.scaffoldBackgroundColor, AppColors.background);
    expect(theme.colorScheme.primaryContainer, AppColors.primaryContainer);
  });
}
