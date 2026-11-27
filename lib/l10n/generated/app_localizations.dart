import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Universidades'**
  String get appTitle;

  /// No description provided for @unitedStatesCaption.
  ///
  /// In es, this message translates to:
  /// **'Estados Unidos'**
  String get unitedStatesCaption;

  /// No description provided for @universitiesTitle.
  ///
  /// In es, this message translates to:
  /// **'Universidades'**
  String get universitiesTitle;

  /// No description provided for @viewAsList.
  ///
  /// In es, this message translates to:
  /// **'Ver como lista'**
  String get viewAsList;

  /// No description provided for @viewAsGrid.
  ///
  /// In es, this message translates to:
  /// **'Ver como cuadrícula'**
  String get viewAsGrid;

  /// No description provided for @loadingMore.
  ///
  /// In es, this message translates to:
  /// **'Cargando más…'**
  String get loadingMore;

  /// No description provided for @detailTitle.
  ///
  /// In es, this message translates to:
  /// **'Detalle'**
  String get detailTitle;

  /// No description provided for @backTooltip.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get backTooltip;

  /// No description provided for @camera.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get gallery;

  /// No description provided for @changeImage.
  ///
  /// In es, this message translates to:
  /// **'Cambiar'**
  String get changeImage;

  /// No description provided for @stateProvinceLabel.
  ///
  /// In es, this message translates to:
  /// **'Estado / provincia'**
  String get stateProvinceLabel;

  /// No description provided for @domainLabel.
  ///
  /// In es, this message translates to:
  /// **'Dominio'**
  String get domainLabel;

  /// No description provided for @websiteLabel.
  ///
  /// In es, this message translates to:
  /// **'Sitio web'**
  String get websiteLabel;

  /// No description provided for @notAvailable.
  ///
  /// In es, this message translates to:
  /// **'No disponible'**
  String get notAvailable;

  /// No description provided for @studentCountLabel.
  ///
  /// In es, this message translates to:
  /// **'Número de estudiantes'**
  String get studentCountLabel;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @emptyUniversities.
  ///
  /// In es, this message translates to:
  /// **'No hay universidades disponibles.'**
  String get emptyUniversities;

  /// No description provided for @universityNotFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontró la universidad.'**
  String get universityNotFound;

  /// No description provided for @backToList.
  ///
  /// In es, this message translates to:
  /// **'Volver a la lista'**
  String get backToList;

  /// No description provided for @savedSuccess.
  ///
  /// In es, this message translates to:
  /// **'Guardado correctamente.'**
  String get savedSuccess;

  /// No description provided for @permissionDenied.
  ///
  /// In es, this message translates to:
  /// **'Se denegó el permiso para usar la cámara o la galería.'**
  String get permissionDenied;

  /// No description provided for @imagePickFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo seleccionar la imagen.'**
  String get imagePickFailed;

  /// No description provided for @studentCountEmpty.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un número de estudiantes.'**
  String get studentCountEmpty;

  /// No description provided for @studentCountNotANumber.
  ///
  /// In es, this message translates to:
  /// **'El valor debe ser un número entero.'**
  String get studentCountNotANumber;

  /// No description provided for @studentCountMustBePositive.
  ///
  /// In es, this message translates to:
  /// **'El valor debe ser mayor que cero.'**
  String get studentCountMustBePositive;

  /// No description provided for @studentCountTooLarge.
  ///
  /// In es, this message translates to:
  /// **'El valor no puede superar 1.000.000.'**
  String get studentCountTooLarge;

  /// No description provided for @failureNetwork.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error de red. Inténtalo de nuevo.'**
  String get failureNetwork;

  /// No description provided for @failureParsing.
  ///
  /// In es, this message translates to:
  /// **'No se pudo procesar la respuesta.'**
  String get failureParsing;

  /// No description provided for @failureUnexpected.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error inesperado.'**
  String get failureUnexpected;

  /// No description provided for @failureNotFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontró la universidad.'**
  String get failureNotFound;

  /// No description provided for @failurePermissionDenied.
  ///
  /// In es, this message translates to:
  /// **'Se denegó el permiso para usar la cámara o la galería.'**
  String get failurePermissionDenied;

  /// No description provided for @failureCameraUnavailable.
  ///
  /// In es, this message translates to:
  /// **'La cámara no está disponible en este dispositivo.'**
  String get failureCameraUnavailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
