import 'package:auth/auth.dart';
import 'package:favorite/favorite.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';

class AppRoutes {
  const AppRoutes._();

  static const login = '/login';
  static const home = '/home';
  static const movieDetail = '/movie-detail';
  static const search = '/search';
  static const favorite = '/favorite';
  static const profile = '/profile';
}

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return switch (settings.name) {
          AppRoutes.login => LoginPage(
            loginBloc: createLoginBloc(),
            onLogin: (_) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },
          ),
          AppRoutes.home => HomePage(
            homeBloc: createHomeBloc(),
            onSearchTap: () {
              Navigator.of(context).pushNamed(AppRoutes.search);
            },
            onFavoriteTap: () {
              Navigator.of(context).pushNamed(AppRoutes.favorite);
            },
            onProfileTap: () {
              Navigator.of(context).pushNamed(AppRoutes.profile);
            },
            onMovieTap: (movieId) {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.movieDetail, arguments: movieId);
            },
          ),
          AppRoutes.movieDetail => MovieDetailPage(
            movieId: _movieIdFromArguments(settings.arguments),
            detailBloc: createMovieDetailBloc(),
            onRelatedMovieTap: (movieId) {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.movieDetail, arguments: movieId);
            },
          ),
          AppRoutes.search => SearchPage(
            searchBloc: createSearchBloc(),
            onHomeTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },
            onFavoriteTap: () {
              Navigator.of(context).pushNamed(AppRoutes.favorite);
            },
            onProfileTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
            },
            onMovieTap: (movieId) {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.movieDetail, arguments: movieId);
            },
          ),
          AppRoutes.favorite => FavoritePage(
            favoriteBloc: createFavoriteBloc(),
            onHomeTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },
            onSearchTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.search);
            },
            onProfileTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
            },
            onMovieTap: (movieId) {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.movieDetail, arguments: movieId);
            },
          ),
          AppRoutes.profile => ProfilePage(
            profileBloc: createProfileBloc(),
            onHomeTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },
            onSearchTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.search);
            },
            onFavoriteTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.favorite);
            },
            onLogout: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
          _ => const _RoutePlaceholderPage(
            title: 'Halaman Tidak Ditemukan',
            routeName: 'unknown',
          ),
        };
      },
    );
  }
}

int _movieIdFromArguments(Object? arguments) {
  if (arguments is int) {
    return arguments;
  }

  return 0;
}

class _RoutePlaceholderPage extends StatelessWidget {
  const _RoutePlaceholderPage({
    required this.title,
    required this.routeName,
  });

  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          routeName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
