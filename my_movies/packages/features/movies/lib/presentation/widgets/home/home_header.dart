import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceContainerHighest,
            child: Icon(
              Icons.movie_filter_rounded,
              color: AppColors.cinematicRed,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat malam,',
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.mutedSilver,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'Akbar',
                  style: AppTextStyles.titleMd.copyWith(
                    color: AppColors.onSurface,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            color: AppColors.onSurface,
            tooltip: 'Notifikasi',
          ),
        ],
      ),
    );
  }
}
