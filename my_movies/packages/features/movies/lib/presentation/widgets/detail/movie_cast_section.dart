import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/movie_detail_view_model.dart';

class MovieCastSection extends StatelessWidget {
  const MovieCastSection({
    super.key,
    required this.cast,
  });

  final List<CastMemberViewModel> cast;

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cast',
            style: AppTextStyles.titleMd.copyWith(
              color: AppColors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = cast[index];
                return Tooltip(
                  message: '${item.name} as ${item.character}',
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.surfaceContainerHigh,
                    backgroundImage: item.profileUrl == null
                        ? null
                        : NetworkImage(item.profileUrl!),
                    child: item.profileUrl == null
                        ? const Icon(Icons.person_rounded)
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
