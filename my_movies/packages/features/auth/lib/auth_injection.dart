import 'package:core_services/core_services.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/get_saved_auth_session.dart';
import 'domain/usecases/login_as_guest.dart';
import 'domain/usecases/login_with_tmdb.dart';
import 'domain/usecases/logout_from_tmdb.dart';
import 'presentation/bloc/login/login_bloc.dart';

final authSl = GetIt.instance;

void setupAuthDependencies({GetIt? getIt}) {
  final sl = getIt ?? authSl;

  setupCoreServicesDependencies(getIt: sl);

  if (!sl.isRegistered<AuthRemoteDataSource>()) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );
  }

  if (!sl.isRegistered<AuthLocalDataSource>()) {
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<LocalStorageService>()),
    );
  }

  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        localDataSource: sl<AuthLocalDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<LoginWithTmdb>()) {
    sl.registerLazySingleton<LoginWithTmdb>(
      () => LoginWithTmdb(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<LoginAsGuest>()) {
    sl.registerLazySingleton<LoginAsGuest>(
      () => LoginAsGuest(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<GetSavedAuthSession>()) {
    sl.registerLazySingleton<GetSavedAuthSession>(
      () => GetSavedAuthSession(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<LogoutFromTmdb>()) {
    sl.registerLazySingleton<LogoutFromTmdb>(
      () => LogoutFromTmdb(sl<AuthRepository>()),
    );
  }

  if (!sl.isRegistered<LoginBloc>()) {
    sl.registerFactory<LoginBloc>(
      () => LoginBloc(
        loginWithTmdb: sl<LoginWithTmdb>(),
        loginAsGuest: sl<LoginAsGuest>(),
      ),
    );
  }
}

LoginBloc createLoginBloc({
  DioClient? dioClient,
  LocalStorageService? storageService,
}) {
  if (dioClient == null && storageService == null) {
    setupAuthDependencies();
    return authSl<LoginBloc>();
  }

  final remoteDataSource = AuthRemoteDataSourceImpl(
    dioClient: dioClient ?? DioClient(),
  );
  final localDataSource = AuthLocalDataSourceImpl(
    storageService ?? const SecureStorageService(),
  );
  final repository = AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  return LoginBloc(
    loginWithTmdb: LoginWithTmdb(repository),
    loginAsGuest: LoginAsGuest(repository),
  );
}
