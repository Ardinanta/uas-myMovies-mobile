import 'package:dio/dio.dart';

import '../api/tmdb_api.dart';
import '../constants/tmdb_constants.dart';
import '../error/exception.dart';
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

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    final response = await _dio.get<Object?>(
      path,
      queryParameters: queryParameters,
    );

    return _asJsonObject(response.data, path);
  }

  Future<Map<String, dynamic>> getNowPlayingMovies({int page = 1}) {
    return get(
      TmdbApi.nowPlayingMovies,
      queryParameters: {'page': page},
    );
  }

  Future<Map<String, dynamic>> getMovieDetail(int movieId) {
    return get(TmdbApi.movieDetailById(movieId));
  }

  Future<Map<String, dynamic>> searchMovies({
    required String query,
    int page = 1,
  }) {
    return get(
      TmdbApi.searchMovies,
      queryParameters: {
        'query': query,
        'page': page,
        'include_adult': false,
      },
    );
  }

  Map<String, dynamic> _asJsonObject(Object? data, String path) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return data.map((key, value) => MapEntry('$key', value));
    }

    throw ServerException(
      message: 'Response API bukan object JSON.',
      path: path,
    );
  }

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
