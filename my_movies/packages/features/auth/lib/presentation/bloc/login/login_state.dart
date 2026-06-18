import '../../../domain/entities/auth_session.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
}

class LoginState {
  const LoginState({
    required this.status,
    this.session,
    this.message,
  });

  const LoginState.initial() : this(status: LoginStatus.initial);

  final LoginStatus status;
  final AuthSession? session;
  final String? message;

  LoginState copyWith({
    LoginStatus? status,
    AuthSession? session,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      session: session ?? this.session,
      message: message,
    );
  }
}
