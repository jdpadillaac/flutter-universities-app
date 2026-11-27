# Detalle de universidad

`UniversityDetailPage` monta `UniversityDetailBloc` con `UniversityDetailRequested(id)`. UI: `UniversityImagePicker`, nombre, chip país, `UniversityInfoCard` y `StudentCountCard`.

Cámara y galería disparan eventos al bloc; `StudentCountField` valida dígitos y habilita Guardar solo con `StudentCount` válido. SnackBars usan `AppLocalizations`.

Extras en `UniversityExtrasRepository` (sesión). Id de ruta ausente o universidad desconocida → `notFound` con `UniversityNotFoundView` y botón `backToList`.