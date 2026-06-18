import 'package:core_services/core_services.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/auth_create_session_request_model.dart';
import '../models/auth_delete_session_request_model.dart';
import '../models/auth_request_token_model.dart';
import '../models/auth_session_model.dart';
import '../models/auth_validate_login_request_model.dart';
import '../models/guest_session_model.dart';
import '../models/tmdb_account_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) = _AuthApiService;

  @GET(TmdbApi.createRequestToken)
  Future<AuthRequestTokenModel> createRequestToken();

  @POST(TmdbApi.validateRequestTokenWithLogin)
  Future<AuthRequestTokenModel> validateRequestTokenWithLogin(
    @Body() AuthValidateLoginRequestModel request,
  );

  @POST(TmdbApi.createSession)
  Future<AuthSessionModel> createSession(
    @Body() AuthCreateSessionRequestModel request,
  );

  @DELETE(TmdbApi.deleteSession)
  Future<void> deleteSession(
    @Body() AuthDeleteSessionRequestModel request,
  );

  @GET(TmdbApi.createGuestSession)
  Future<GuestSessionModel> createGuestSession();

  @GET(TmdbApi.account)
  Future<TmdbAccountModel> getAccount(
    @Query('session_id') String sessionId,
  );
}
