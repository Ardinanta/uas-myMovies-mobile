class ServerException implements Exception {
  const ServerException({
    required this.message,
    this.statusCode,
    this.path,
  });

  final String message;
  final int? statusCode;
  final String? path;

  @override
  String toString() {
    final statusText = statusCode == null ? '' : ' ($statusCode)';
    final pathText = path == null ? '' : ' [$path]';
    return 'ServerException$statusText: $message$pathText';
  }
}

class CacheException implements Exception {
  const CacheException(this.message);

  final String message;

  @override
  String toString() => 'CacheException: $message';
}

class NoInternetException implements Exception {
  const NoInternetException();

  @override
  String toString() => 'NoInternetException: Tidak ada koneksi internet.';
}

class MissingApiKeyException implements Exception {
  const MissingApiKeyException();

  @override
  String toString() => 'MissingApiKeyException: TMDb API key belum diset.';
}
