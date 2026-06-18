import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class MovieOverviewSection extends StatelessWidget {
  const MovieOverviewSection({
    super.key,
    required this.overview,
  });

  final String overview;

  @override
  Widget build(BuildContext context) {
    return _DetailSection(
      title: 'Overview',
      child: Text(
        overview.isEmpty ? 'Tidak ada overview untuk film ini.' : overview,
        style: AppTextStyles.bodySm.copyWith(
          color: AppColors.onSurface,
          height: 1.5,
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.titleMd.copyWith(
              color: AppColors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
