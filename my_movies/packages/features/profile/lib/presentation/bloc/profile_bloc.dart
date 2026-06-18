import 'package:auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetSavedAuthSession getSavedAuthSession,
    required LogoutFromTmdb logoutFromTmdb,
  }) : _getSavedAuthSession = getSavedAuthSession,
       _logoutFromTmdb = logoutFromTmdb,
       super(const ProfileState.initial()) {
    on<ProfileStarted>(_onStarted);
    on<ProfileLogoutRequested>(_onLogoutRequested);
  }

  final GetSavedAuthSession _getSavedAuthSession;
  final LogoutFromTmdb _logoutFromTmdb;

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading, message: null));

    try {
      final result = await _getSavedAuthSession();

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              message: failure.message,
            ),
          );
        },
        (session) {
          final username = session?.username.trim();
          emit(
            state.copyWith(
              status: ProfileStatus.success,
              username: username?.isNotEmpty == true ? username! : 'Guest',
              isGuest: session?.isGuest ?? false,
              message: null,
            ),
          );
        },
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          message: 'Gagal memuat profile.',
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    ProfileLogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loggingOut, message: null));

    try {
      final result = await _logoutFromTmdb();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              message: failure.message,
            ),
          );
        },
        (_) {
          emit(state.copyWith(status: ProfileStatus.loggedOut));
        },
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          message: 'Gagal logout.',
        ),
      );
    }
  }
}
