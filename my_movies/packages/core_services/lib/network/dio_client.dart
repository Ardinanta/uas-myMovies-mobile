import 'package:dio/dio.dart';

import '../constants/tmdb_constants.dart';
import '../storage/local_storage_service.dart';
import '../storage/secure_storage_service.dart';
import 'api_interceptor.dart';
import 'auth_interceptor.dart';

class DioClient {
  DioClient({
    Dio? dio,
    LocalStorageService? storageService,
  }) : _dio = dio ?? _createDio(storageService);

  final Dio _dio;

  Dio get raw => _dio;

  static Dio _createDio(LocalStorageService? storageService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: TmdbConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
        headers: const {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(const ApiInterceptor());
    dio.interceptors.add(
      AuthInterceptor(
        storageService: storageService ?? const SecureStorageService(),
      ),
    );
    return dio;
  }
}
