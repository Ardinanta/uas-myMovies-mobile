import 'package:auth/auth.dart';
import 'package:get_it/get_it.dart';

import 'presentation/bloc/profile_bloc.dart';

final profileSl = GetIt.instance;

void setupProfileDependencies({GetIt? getIt}) {
  final sl = getIt ?? profileSl;

  setupAuthDependencies(getIt: sl);

  if (!sl.isRegistered<ProfileBloc>()) {
    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getSavedAuthSession: sl<GetSavedAuthSession>(),
        logoutFromTmdb: sl<LogoutFromTmdb>(),
      ),
    );
  }
}

ProfileBloc createProfileBloc() {
  setupProfileDependencies();
  return profileSl<ProfileBloc>();
}
