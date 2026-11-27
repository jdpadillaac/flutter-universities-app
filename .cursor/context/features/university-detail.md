# Detalle de universidad

Page, bloc y widgets: `lib/features/universities/presentation/pages/university_detail/`. `WebsiteDisplay` y `StudentCountErrorMessage` viven en esa carpeta. `FailureMessageResolver` vive en `presentation/helpers/`.

`UniversityDetailPage` monta `UniversityDetailBloc` con `UniversityDetailRequested(id)`. Estados sellados: `UniversityDetailLoading`, `UniversityDetailNotFound`, `UniversityDetailLoaded`. UI en loaded: `UniversityImagePicker`, nombre, chip país, `UniversityInfoCard` y `StudentCountCard`.

Cámara y galería disparan eventos al bloc; `StudentCountField` valida dígitos y habilita Guardar solo con `StudentCount` válido. SnackBars usan `AppLocalizations`.

Extras en `UniversityExtrasRepository` (sesión). Id de ruta ausente o universidad desconocida → `notFound` con `UniversityNotFoundView` y botón `backToList`.