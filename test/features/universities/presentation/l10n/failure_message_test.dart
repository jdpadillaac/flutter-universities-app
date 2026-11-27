import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/presentation/l10n/failure_message.dart';
import 'package:universities_app/l10n/generated/app_localizations_es.dart';

void main() {
  const message = FailureMessage();

  test('maps failure types to localized text', () {
    final l10n = AppLocalizationsEs();
    expect(message.resolve(const NetworkFailure(), l10n), l10n.failureNetwork);
    expect(message.resolve(const ParsingFailure(), l10n), l10n.failureParsing);
    expect(
      message.resolve(const NotFoundFailure(), l10n),
      l10n.failureNotFound,
    );
    expect(
      message.resolve(const UnexpectedFailure(), l10n),
      l10n.failureUnexpected,
    );
    expect(
      message.resolve(const PermissionDeniedFailure(), l10n),
      l10n.failurePermissionDenied,
    );
    expect(
      message.resolve(const CameraUnavailableFailure(), l10n),
      l10n.failureCameraUnavailable,
    );
  });
}
