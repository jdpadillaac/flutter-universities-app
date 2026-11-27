import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class FailureMessage {
  const FailureMessage();

  String resolve(Failure failure, AppLocalizations l10n) {
    return switch (failure) {
      NetworkFailure() => l10n.failureNetwork,
      ParsingFailure() => l10n.failureParsing,
      NotFoundFailure() => l10n.failureNotFound,
      UnexpectedFailure() => l10n.failureUnexpected,
      PermissionDeniedFailure() => l10n.failurePermissionDenied,
      CameraUnavailableFailure() => l10n.failureCameraUnavailable,
    };
  }
}
