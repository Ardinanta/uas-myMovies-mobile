import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/home_movie_view_model.dart';

class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({
    super.key,
    required this.movie,
    required this.onWatchTap,
  });

  final HomeMovieViewModel movie;
  final VoidCallback onWatchTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.78,
      child: ClipRRect(
        borderRadius: AppRadius.lgBorder,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (movie.backdropUrl == null)
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff10212a),
                      Color(0xff1f2937),
                      Color(0xff23070a),
                    ],
                  ),
                ),
              )
            else
              Image.network(
                movie.backdropUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff10212a),
                          Color(0xff1f2937),
                          Color(0xff23070a),
                        ],
                      ),
                    ),
                  );
                },
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.18),
                    AppColors.background.withValues(alpha: 0.88),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRENDING SEKARANG',
                    style: AppTextStyles.labelCaps.copyWith(
                      color: AppColors.cinematicRed,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.displayLg.copyWith(
                      color: AppColors.white,
                      fontSize: 34,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: onWatchTap,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(132, 42),
                      textStyle: AppTextStyles.bodySm.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    child: const Text('Tonton Sekarang'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeroCarousel extends StatefulWidget {
  const HomeHeroCarousel({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  final List<HomeMovieViewModel> movies;
  final ValueChanged<HomeMovieViewModel> onMovieTap;

  @override
  State<HomeHeroCarousel> createState() => _HomeHeroCarouselState();
}

class _HomeHeroCarouselState extends State<HomeHeroCarousel> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 350,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return HomeHeroBanner(
                movie: movie,
                onWatchTap: () => widget.onMovieTap(movie),
              );
            },
          ),
        ),
        Positioned(
          left: 12,
          child: _HeroArrowButton(
            icon: Icons.chevron_left_rounded,
            onPressed: _previous,
            tooltip: 'Sebelumnya',
          ),
        ),
        Positioned(
          right: 12,
          child: _HeroArrowButton(
            icon: Icons.chevron_right_rounded,
            onPressed: _next,
            tooltip: 'Berikutnya',
          ),
        ),
        Positioned(
          bottom: 18,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.movies.length, (index) {
              final isActive = index == _currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.cinematicRed
                      : AppColors.white.withValues(alpha: 0.35),
                  borderRadius: AppRadius.fullBorder,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _previous() {
    final targetIndex = _currentIndex == 0
        ? widget.movies.length - 1
        : _currentIndex - 1;
    _pageController.animateToPage(
      targetIndex,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  void _next() {
    final targetIndex = _currentIndex == widget.movies.length - 1
        ? 0
        : _currentIndex + 1;
    _pageController.animateToPage(
      targetIndex,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }
}

class _HeroArrowButton extends StatelessWidget {
  const _HeroArrowButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon),
      tooltip: tooltip,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.surfaceContainerLowest.withValues(
          alpha: onPressed == null ? 0.22 : 0.62,
        ),
        disabledBackgroundColor: AppColors.surfaceContainerLowest.withValues(
          alpha: 0.22,
        ),
        foregroundColor: AppColors.white,
        disabledForegroundColor: AppColors.mutedSilver,
      ),
    );
  }
}
