// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Universidades';

  @override
  String get unitedStatesCaption => 'Estados Unidos';

  @override
  String get universitiesTitle => 'Universidades';

  @override
  String get viewAsList => 'Ver como lista';

  @override
  String get viewAsGrid => 'Ver como cuadrícula';

  @override
  String get loadingMore => 'Cargando más…';

  @override
  String get detailTitle => 'Detalle';

  @override
  String get backTooltip => 'Volver';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get changeImage => 'Cambiar';

  @override
  String get stateProvinceLabel => 'Estado / provincia';

  @override
  String get domainLabel => 'Dominio';

  @override
  String get websiteLabel => 'Sitio web';

  @override
  String get notAvailable => 'No disponible';

  @override
  String get studentCountLabel => 'Número de estudiantes';

  @override
  String get save => 'Guardar';

  @override
  String get retry => 'Reintentar';

  @override
  String get emptyUniversities => 'No hay universidades disponibles.';

  @override
  String get universityNotFound => 'No se encontró la universidad.';

  @override
  String get backToList => 'Volver a la lista';

  @override
  String get savedSuccess => 'Guardado correctamente.';

  @override
  String get permissionDenied =>
      'Se denegó el permiso para usar la cámara o la galería.';

  @override
  String get imagePickFailed => 'No se pudo seleccionar la imagen.';

  @override
  String get studentCountEmpty => 'Ingresa un número de estudiantes.';

  @override
  String get studentCountNotANumber => 'El valor debe ser un número entero.';

  @override
  String get studentCountMustBePositive => 'El valor debe ser mayor que cero.';

  @override
  String get studentCountTooLarge => 'El valor no puede superar 1.000.000.';

  @override
  String get failureNetwork => 'Ocurrió un error de red. Inténtalo de nuevo.';

  @override
  String get failureParsing => 'No se pudo procesar la respuesta.';

  @override
  String get failureUnexpected => 'Ocurrió un error inesperado.';

  @override
  String get failureNotFound => 'No se encontró la universidad.';
}
