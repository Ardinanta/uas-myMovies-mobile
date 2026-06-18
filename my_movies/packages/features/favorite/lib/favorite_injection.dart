import 'package:core_services/core_services.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/favorite_local_data_source.dart';
import 'data/repositories/favorite_repository_impl.dart';
import 'domain/repositories/favorite_repository.dart';
import 'domain/usecases/add_favorite_movie.dart';
import 'domain/usecases/get_favorite_movies.dart';
import 'domain/usecases/is_movie_favorite.dart';
import 'domain/usecases/remove_favorite_movie.dart';
import 'domain/usecases/toggle_favorite_movie.dart';
import 'presentation/bloc/favorite_bloc.dart';

final favoriteSl = GetIt.instance;

void setupFavoriteDependencies({GetIt? getIt}) {
  final sl = getIt ?? favoriteSl;

  setupCoreServicesDependencies(getIt: sl);

  if (!sl.isRegistered<FavoriteLocalDataSource>()) {
    sl.registerLazySingleton<FavoriteLocalDataSource>(
      () => FavoriteLocalDataSourceImpl(sl<LocalStorageService>()),
    );
  }

  if (!sl.isRegistered<FavoriteRepository>()) {
    sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(sl<FavoriteLocalDataSource>()),
    );
  }

  if (!sl.isRegistered<GetFavoriteMovies>()) {
    sl.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(sl<FavoriteRepository>()),
    );
  }
  if (!sl.isRegistered<IsMovieFavorite>()) {
    sl.registerLazySingleton<IsMovieFavorite>(
      () => IsMovieFavorite(sl<FavoriteRepository>()),
    );
  }
  if (!sl.isRegistered<AddFavoriteMovie>()) {
    sl.registerLazySingleton<AddFavoriteMovie>(
      () => AddFavoriteMovie(sl<FavoriteRepository>()),
    );
  }
  if (!sl.isRegistered<RemoveFavoriteMovie>()) {
    sl.registerLazySingleton<RemoveFavoriteMovie>(
      () => RemoveFavoriteMovie(sl<FavoriteRepository>()),
    );
  }
  if (!sl.isRegistered<ToggleFavoriteMovie>()) {
    sl.registerLazySingleton<ToggleFavoriteMovie>(
      () => ToggleFavoriteMovie(sl<FavoriteRepository>()),
    );
  }

  if (!sl.isRegistered<FavoriteBloc>()) {
    sl.registerFactory<FavoriteBloc>(
      () => FavoriteBloc(
        getFavoriteMovies: sl<GetFavoriteMovies>(),
        removeFavoriteMovie: sl<RemoveFavoriteMovie>(),
      ),
    );
  }
}

FavoriteBloc createFavoriteBloc({
  LocalStorageService? storageService,
}) {
  if (storageService == null) {
    setupFavoriteDependencies();
    return favoriteSl<FavoriteBloc>();
  }

  final localDataSource = FavoriteLocalDataSourceImpl(storageService);
  final repository = FavoriteRepositoryImpl(localDataSource);

  return FavoriteBloc(
    getFavoriteMovies: GetFavoriteMovies(repository),
    removeFavoriteMovie: RemoveFavoriteMovie(repository),
  );
}
