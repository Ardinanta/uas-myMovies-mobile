import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum AppBottomNavItem {
  home,
  search,
  favorite,
  profile,
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  final AppBottomNavItem currentItem;
  final ValueChanged<AppBottomNavItem> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.92),
        border: Border(
          top: BorderSide(color: AppColors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: AppBottomNavItem.values.map((item) {
              return Expanded(
                child: _BottomNavButton(
                  item: item,
                  isSelected: item == currentItem,
                  onTap: () => onItemSelected(item),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _BottomNavButton extends StatelessWidget {
  const _BottomNavButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.cinematicRed : AppColors.mutedSilver;

    return Tooltip(
      message: item.label,
      child: InkResponse(
        onTap: onTap,
        radius: 28,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: color, size: 22),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: isSelected ? 16 : 4,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.transparent,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on AppBottomNavItem {
  IconData get icon {
    return switch (this) {
      AppBottomNavItem.home => Icons.home_rounded,
      AppBottomNavItem.search => Icons.search_rounded,
      AppBottomNavItem.favorite => Icons.favorite_border_rounded,
      AppBottomNavItem.profile => Icons.person_outline_rounded,
    };
  }

  String get label {
    return switch (this) {
      AppBottomNavItem.home => 'Home',
      AppBottomNavItem.search => 'Search',
      AppBottomNavItem.favorite => 'Favorite',
      AppBottomNavItem.profile => 'Profile',
    };
  }
}
