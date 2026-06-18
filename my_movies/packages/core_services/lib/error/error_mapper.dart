import 'package:dio/dio.dart';

import 'exception.dart';
import 'failure.dart';

abstract class ErrorMapper {
  const ErrorMapper._();

  static Failure map(Object error) {
    return switch (error) {
      MissingApiKeyException() => const Failure(
        type: FailureType.missingApiKey,
        message: 'TMDb API key belum diset.',
      ),
      MissingAuthSessionException() => const Failure(
        type: FailureType.missingAuthSession,
        message: 'Silakan login terlebih dahulu.',
      ),
      ServerException() => Failure(
        type: _failureTypeFromStatusCode(error.statusCode),
        message: error.message,
        statusCode: error.statusCode,
      ),
      CacheException() => Failure(
        type: FailureType.cache,
        message: error.message,
      ),
      NoInternetException() => const Failure(
        type: FailureType.noInternet,
        message: 'Tidak ada koneksi internet.',
      ),
      DioException() => _mapDioException(error),
      FormatException() => Failure(
        type: FailureType.parse,
        message: 'Format response API tidak valid.',
      ),
      _ => const Failure(
        message: 'Terjadi kesalahan. Silakan coba lagi.',
      ),
    };
  }

  static Failure _mapDioException(DioException error) {
    final innerError = error.error;
    if (innerError is MissingApiKeyException) {
      return map(innerError);
    }
    if (innerError is MissingAuthSessionException) {
      return map(innerError);
    }

    final statusCode = error.response?.statusCode;
    final responseMessage = _messageFromResponse(error.response?.data);

    return switch (error.type) {
      DioExceptionType.connectionTimeout => const Failure(
        type: FailureType.connectionTimeout,
        message: 'Koneksi ke server terlalu lama.',
      ),
      DioExceptionType.sendTimeout => const Failure(
        type: FailureType.sendTimeout,
        message: 'Waktu mengirim request habis.',
      ),
      DioExceptionType.receiveTimeout => const Failure(
        type: FailureType.receiveTimeout,
        message: 'Waktu menerima response habis.',
      ),
      DioExceptionType.badCertificate => const Failure(
        type: FailureType.badCertificate,
        message: 'Sertifikat server tidak valid.',
      ),
      DioExceptionType.badResponse => Failure(
        type: _failureTypeFromStatusCode(statusCode),
        message: responseMessage ?? 'Request ke TMDb gagal.',
        statusCode: statusCode,
      ),
      DioExceptionType.cancel => const Failure(
        type: FailureType.cancelled,
        message: 'Request dibatalkan.',
      ),
      DioExceptionType.connectionError => const Failure(
        type: FailureType.connectionError,
        message: 'Tidak dapat terhubung ke server.',
      ),
      DioExceptionType.unknown => Failure(
        message: error.message ?? 'Terjadi kesalahan tidak diketahui.',
        statusCode: statusCode,
      ),
    };
  }

  static FailureType _failureTypeFromStatusCode(int? statusCode) {
    if (statusCode == null) {
      return FailureType.unknown;
    }

    return FailureType.badResponse;
  }

  static String? _messageFromResponse(Object? data) {
    if (data is Map<String, dynamic>) {
      final message = data['status_message'] ?? data['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return null;
  }
}
