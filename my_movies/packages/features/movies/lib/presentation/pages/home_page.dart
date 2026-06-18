import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../widgets/home/home_header.dart';
import '../widgets/home/home_hero_banner.dart';
import '../widgets/home/movie_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.homeBloc,
    required this.onSearchTap,
    required this.onFavoriteTap,
    required this.onProfileTap,
    required this.onMovieTap,
  });

  final HomeBloc homeBloc;
  final VoidCallback onSearchTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onProfileTap;
  final ValueChanged<int> onMovieTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => homeBloc..add(const HomeStarted()),
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: AppBottomNavBar(
          currentItem: AppBottomNavItem.home,
          onItemSelected: (item) {
            switch (item) {
              case AppBottomNavItem.home:
                break;
              case AppBottomNavItem.search:
                onSearchTap();
              case AppBottomNavItem.favorite:
                onFavoriteTap();
              case AppBottomNavItem.profile:
                onProfileTap();
            }
          },
        ),
        body: SafeArea(
          bottom: false,
          child: AppRefreshIndicator(
            onRefresh: () => _refresh(context),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: HomeHeader()),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return switch (state.status) {
                      HomeStatus.initial || HomeStatus.loading =>
                        const SliverToBoxAdapter(child: _HomeLoadingState()),
                      HomeStatus.failure => SliverToBoxAdapter(
                        child: _HomeErrorState(
                          message: state.message ?? 'Gagal memuat film.',
                          onRetry: () {
                            context.read<HomeBloc>().add(const HomeRetried());
                          },
                        ),
                      ),
                      HomeStatus.empty => const SliverToBoxAdapter(
                        child: _HomeEmptyState(),
                      ),
                      HomeStatus.success => SliverList.list(
                        children: [
                          if (state.trendingMovies.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 14, 20, 28),
                              child: HomeHeroCarousel(
                                movies: state.trendingMovies,
                                onMovieTap: (movie) => onMovieTap(movie.id),
                              ),
                            ),
                          MovieSection(
                            title: 'Popular Movies',
                            movies: state.popularMovies,
                            onMovieTap: (movie) => onMovieTap(movie.id),
                          ),
                          MovieSection(
                            title: 'Top Rated Movies',
                            movies: state.topRatedMovies,
                            isLarge: true,
                            onMovieTap: (movie) => onMovieTap(movie.id),
                          ),
                          MovieSection(
                            title: 'Upcoming Movies',
                            movies: state.upcomingMovies,
                            onMovieTap: (movie) => onMovieTap(movie.id),
                          ),
                          const SizedBox(height: 92),
                        ],
                      ),
                    };
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<HomeBloc>()..add(const HomeRetried());
    await bloc.stream.firstWhere((state) => state.status != HomeStatus.loading);
  }
}

class _HomeLoadingState extends StatelessWidget {
  const _HomeLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.cinematicRed),
      ),
    );
  }
}

class _HomeErrorState extends StatelessWidget {
  const _HomeErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: AppRadius.lgBorder,
          border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                color: AppColors.cinematicRed,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: onRetry, child: const Text('Coba Lagi')),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeEmptyState extends StatelessWidget {
  const _HomeEmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Text(
        'Belum ada film yang bisa ditampilkan.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyMd.copyWith(color: AppColors.mutedSilver),
      ),
    );
  }
}
