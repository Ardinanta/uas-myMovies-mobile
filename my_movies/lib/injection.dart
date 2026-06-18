import 'package:auth/auth.dart';
import 'package:core_services/core_services.dart';
import 'package:favorite/favorite.dart';
import 'package:movies/movies.dart';

void configureDependencies() {
  setupCoreServicesDependencies();
  setupAuthDependencies();
  setupMoviesDependencies();
  setupFavoriteDependencies();
}
