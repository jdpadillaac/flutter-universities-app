import 'package:equatable/equatable.dart';

/// Domain error type used as the error type in oxidized `Result<T, E>`.
///
/// Example: `Future<Result<University, Failure>> fetchUniversity(...)`.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// A network or HTTP-layer error.
final class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'A network error occurred.',
    this.statusCode,
  }) : super(message);

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// JSON or model parsing failed.
final class ParsingFailure extends Failure {
  const ParsingFailure({String message = 'Failed to parse response.'})
    : super(message);
}

/// Catch-all for unclassified errors.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String message = 'An unexpected error occurred.'})
    : super(message);
}
