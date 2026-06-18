import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search/search_bloc.dart';
import '../bloc/search/search_event.dart';
import '../bloc/search/search_state.dart';
import '../widgets/search/genre_preview_grid.dart';
import '../widgets/search/search_input_bar.dart';
import '../widgets/search/search_movie_section.dart';
import '../widgets/search/trending_chip_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.searchBloc,
    required this.onHomeTap,
    required this.onFavoriteTap,
    required this.onMovieTap,
  });

  final SearchBloc searchBloc;
  final VoidCallback onHomeTap;
  final VoidCallback onFavoriteTap;
  final ValueChanged<int> onMovieTap;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_refreshInput);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshInput)
      ..dispose();
    super.dispose();
  }

  void _refreshInput() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.searchBloc..add(const SearchStarted()),
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: AppBottomNavBar(
          currentItem: AppBottomNavItem.search,
          onItemSelected: (item) {
            switch (item) {
              case AppBottomNavItem.home:
                widget.onHomeTap();
              case AppBottomNavItem.search:
                break;
              case AppBottomNavItem.favorite:
                widget.onFavoriteTap();
              case AppBottomNavItem.profile:
                break;
            }
          },
        ),
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
                      child: SearchInputBar(
                        controller: _searchController,
                        onSubmitted: (query) {
                          context.read<SearchBloc>().add(
                            SearchSubmitted(query),
                          );
                        },
                        onClear: () {
                          _searchController.clear();
                          context.read<SearchBloc>().add(const SearchCleared());
                        },
                      ),
                    ),
                  ),
                  if (state.status == SearchStatus.failure)
                    SliverToBoxAdapter(
                      child: _SearchErrorState(
                        message: state.message ?? 'Gagal memuat search.',
                        onRetry: () {
                          context.read<SearchBloc>().add(const SearchRetried());
                        },
                      ),
                    )
                  else if (state.status == SearchStatus.loading &&
                      state.trendingMovies.isEmpty)
                    const SliverToBoxAdapter(child: _SearchLoadingState())
                  else if (state.contentMode != SearchContentMode.overview)
                    SliverList.list(
                      children: [
                        if (state.status == SearchStatus.loading)
                          const _SearchLoadingState()
                        else
                          SearchMovieSection(
                            title: state.activeTitle ?? 'Daftar Movie',
                            movies: state.searchResults,
                            onMovieTap: (movie) => widget.onMovieTap(movie.id),
                            showAll: true,
                            leading: SizedBox.square(
                              dimension: 34,
                              child: IconButton.filled(
                                onPressed: () {
                                  context.read<SearchBloc>().add(
                                    const SearchCleared(),
                                  );
                                },
                                icon: const Icon(Icons.arrow_back_rounded),
                                iconSize: 18,
                                tooltip: 'Kembali',
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: AppColors
                                      .surfaceContainerHigh
                                      .withValues(alpha: 0.82),
                                  foregroundColor: AppColors.white,
                                  shape: const CircleBorder(),
                                ),
                              ),
                            ),
                          ),
                        if (state.status == SearchStatus.success &&
                            state.searchResults.isEmpty)
                          const _SearchEmptyState(),
                        const SizedBox(height: 92),
                      ],
                    )
                  else
                    SliverList.list(
                      children: [
                        _SectionTitle(title: 'Sedang Tren'),
                        TrendingChipList(
                          movies: state.trendingMovies,
                          onMovieTap: (movie) => widget.onMovieTap(movie.id),
                        ),
                        const SizedBox(height: 28),
                        _SectionTitle(title: 'Jelajahi Kategori'),
                        GenrePreviewGrid(
                          genres: state.genres,
                          previewMovies: state.genrePreviewMovies,
                          onGenreTap: (genre) {
                            context.read<SearchBloc>().add(
                              SearchGenreSelected(
                                genreId: genre.id,
                                genreName: genre.name,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 28),
                        SearchMovieSection(
                          title: 'Rekomendasi',
                          movies: state.recommendations,
                          onMovieTap: (movie) => widget.onMovieTap(movie.id),
                          trailing: TextButton(
                            onPressed: () {
                              context.read<SearchBloc>().add(
                                const SearchRecommendationsRequested(),
                              );
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'LIHAT SEMUA',
                              style: AppTextStyles.labelCaps.copyWith(
                                color: AppColors.cinematicRed,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 92),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Text(
        title,
        style: AppTextStyles.titleMd.copyWith(
          color: AppColors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

class _SearchLoadingState extends StatelessWidget {
  const _SearchLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.cinematicRed),
      ),
    );
  }
}

class _SearchErrorState extends StatelessWidget {
  const _SearchErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
          ),
          const SizedBox(height: 14),
          FilledButton(onPressed: onRetry, child: const Text('Coba Lagi')),
        ],
      ),
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  const _SearchEmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Text(
        'Film yang kamu cari belum ditemukan.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyMd.copyWith(color: AppColors.mutedSilver),
      ),
    );
  }
}
