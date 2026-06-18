import 'package:dio/dio.dart';

import '../constants/tmdb_constants.dart';
import '../error/exception.dart';

class ApiInterceptor extends Interceptor {
  const ApiInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!TmdbConstants.hasApiKey) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: const MissingApiKeyException(),
          type: DioExceptionType.unknown,
        ),
      );
      return;
    }

    options.queryParameters.addAll({
      'api_key': TmdbConstants.apiKey,
      'language': TmdbConstants.defaultLanguage,
    });

    super.onRequest(options, handler);
  }
}
