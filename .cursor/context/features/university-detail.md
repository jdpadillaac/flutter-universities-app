# Detalle de universidad

`UniversityDetailPage` monta `UniversityDetailBloc` con `UniversityDetailRequested(id)`. Muestra nombre, país, provincia (`No disponible` si es null), dominios y páginas web.

La imagen abre un bottom sheet (Cámara / Galería). El campo de estudiantes usa solo dígitos; Guardar requiere un `StudentCount` válido y muestra confirmación por SnackBar.

Los extras (imagen y conteo) viven en `UniversityExtrasRepository`, en memoria durante la sesión. La carga del catálogo usa `GetUniversityById`; un id desconocido devuelve `NotFoundFailure`.