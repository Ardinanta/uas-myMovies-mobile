import 'package:dio/dio.dart';

import '../error/exception.dart';
import '../storage/auth_storage_keys.dart';
import '../storage/local_storage_service.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor({
    required LocalStorageService storageService,
  }) : _storageService = storageService;

  final LocalStorageService _storageService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresAuth = options.extra['requiresAuth'] == true;
    final isAccountRequest = options.path.startsWith('/account');

    if (!requiresAuth && !isAccountRequest) {
      super.onRequest(options, handler);
      return;
    }

    final sessionId = await _storageService.getString(AuthStorageKeys.sessionId);
    if (sessionId == null || sessionId.trim().isEmpty) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: const MissingAuthSessionException(),
          type: DioExceptionType.unknown,
        ),
      );
      return;
    }

    options.queryParameters.putIfAbsent('session_id', () => sessionId);
    super.onRequest(options, handler);
  }
}
