enum FailureType {
  missingApiKey,
  missingAuthSession,
  noInternet,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancelled,
  connectionError,
  cache,
  parse,
  unknown,
}

class Failure {
  const Failure({
    required this.message,
    this.type = FailureType.unknown,
    this.statusCode,
  });

  final String message;
  final FailureType type;
  final int? statusCode;
}
