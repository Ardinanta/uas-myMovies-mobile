import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_as_guest.dart';
import '../../../domain/usecases/login_with_tmdb.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginWithTmdb loginWithTmdb,
    required LoginAsGuest loginAsGuest,
  }) : _loginWithTmdb = loginWithTmdb,
       _loginAsGuest = loginAsGuest,
       super(const LoginState.initial()) {
    on<LoginSubmitted>(_onSubmitted);
    on<GuestLoginSubmitted>(_onGuestSubmitted);
  }

  final LoginWithTmdb _loginWithTmdb;
  final LoginAsGuest _loginAsGuest;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final username = event.username.trim();
    final password = event.password;

    if (username.isEmpty || password.isEmpty) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          message: 'Username dan password wajib diisi.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading, message: null));

    final result = await _loginWithTmdb(
      username: username,
      password: password,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            message: failure.message,
          ),
        );
      },
      (session) {
        emit(
          state.copyWith(
            status: LoginStatus.success,
            session: session,
            message: null,
          ),
        );
      },
    );
  }

  Future<void> _onGuestSubmitted(
    GuestLoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading, message: null));

    final result = await _loginAsGuest();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            message: failure.message,
          ),
        );
      },
      (session) {
        emit(
          state.copyWith(
            status: LoginStatus.success,
            session: session,
            message: null,
          ),
        );
      },
    );
  }
}
