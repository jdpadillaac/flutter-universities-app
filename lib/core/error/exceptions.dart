/// Thrown when the HTTP call fails.
class NetworkException implements Exception {
  /// Creates a network exception.
  const NetworkException({
    this.message = 'A network error occurred.',
    this.statusCode,
  });

  /// Human-readable cause, usually from the HTTP client.
  final String message;

  /// HTTP status when the server responded.
  final int? statusCode;
}

/// Thrown when the response body cannot be parsed.
class ParsingException implements Exception {
  /// Creates a parsing exception.
  const ParsingException({this.message = 'Failed to parse response.'});

  /// Human-readable cause.
  final String message;
}
