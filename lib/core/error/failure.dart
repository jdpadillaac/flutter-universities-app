import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'A network error occurred.',
    this.statusCode,
  }) : super(message);

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

final class ParsingFailure extends Failure {
  const ParsingFailure({String message = 'Failed to parse response.'})
    : super(message);
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String message = 'An unexpected error occurred.'})
    : super(message);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'University was not found.'})
    : super(message);
}
