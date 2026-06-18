import 'package:core_services/core_services.dart';

import '../models/auth_create_session_request_model.dart';
import '../models/auth_request_token_model.dart';
import '../models/auth_session_model.dart';
import '../models/auth_validate_login_request_model.dart';
import '../models/guest_session_model.dart';
import '../models/tmdb_account_model.dart';
import 'auth_api_service.dart';

abstract class AuthRemoteDataSource {
  Future<AuthRequestTokenModel> createRequestToken();

  Future<AuthRequestTokenModel> validateRequestTokenWithLogin({
    required String username,
    required String password,
    required String requestToken,
  });

  Future<AuthSessionModel> createSession(String requestToken);

  Future<GuestSessionModel> createGuestSession();

  Future<TmdbAccountModel> getAccount(String sessionId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required DioClient dioClient,
    AuthApiService? apiService,
  }) : _apiService = apiService ?? AuthApiService(dioClient.raw);

  final AuthApiService _apiService;

  @override
  Future<AuthRequestTokenModel> createRequestToken() {
    return _apiService.createRequestToken();
  }

  @override
  Future<AuthRequestTokenModel> validateRequestTokenWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) {
    return _apiService.validateRequestTokenWithLogin(
      AuthValidateLoginRequestModel(
        username: username,
        password: password,
        requestToken: requestToken,
      ),
    );
  }

  @override
  Future<AuthSessionModel> createSession(String requestToken) {
    return _apiService.createSession(
      AuthCreateSessionRequestModel(requestToken: requestToken),
    );
  }

  @override
  Future<GuestSessionModel> createGuestSession() {
    return _apiService.createGuestSession();
  }

  @override
  Future<TmdbAccountModel> getAccount(String sessionId) {
    return _apiService.getAccount(sessionId);
  }
}
