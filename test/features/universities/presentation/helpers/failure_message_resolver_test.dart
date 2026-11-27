import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/presentation/helpers/failure_message_resolver.dart';
import 'package:universities_app/l10n/generated/app_localizations_es.dart';

class _FailureMessageProbe with FailureMessageResolver {
  const _FailureMessageProbe();
}

void main() {
  const message = _FailureMessageProbe();

  test('maps failure types to localized text', () {
    final l10n = AppLocalizationsEs();
    expect(
      message.messageFor(const NetworkFailure(), l10n),
      l10n.failureNetwork,
    );
    expect(
      message.messageFor(const ParsingFailure(), l10n),
      l10n.failureParsing,
    );
    expect(
      message.messageFor(const NotFoundFailure(), l10n),
      l10n.failureNotFound,
    );
    expect(
      message.messageFor(const UnexpectedFailure(), l10n),
      l10n.failureUnexpected,
    );
    expect(
      message.messageFor(const PermissionDeniedFailure(), l10n),
      l10n.failurePermissionDenied,
    );
    expect(
      message.messageFor(const CameraUnavailableFailure(), l10n),
      l10n.failureCameraUnavailable,
    );
  });
}
