# Detalle de universidad

Page, bloc y widgets: `lib/features/universities/presentation/pages/university_detail/`. `WebsiteDisplay` y `StudentCountErrorMessage` viven en esa carpeta. `FailureMessageResolver` vive en `presentation/helpers/`.

`UniversityDetailPage` monta `UniversityDetailBloc` con `UniversityDetailRequested(id)`. Estados sellados: `UniversityDetailLoading`, `UniversityDetailNotFound`, `UniversityDetailLoaded`. Un `id` nulo o cualquier `Err` de `GetUniversityById` (también un fallo de red) emite `UniversityDetailNotFound`, con `UniversityNotFoundView` y botón para volver a la lista.

En loaded la UI es `UniversityImagePicker`, nombre, chip de país, `UniversityInfoCard` y `StudentCountCard`. El conteo está en `student-count.md`. La imagen está en `image-picker.md`.

`UniversityDetailLoaded` también lleva `saveStatus` e `imageFailure`. `_UniversityDetailFeedbackListener` usa el mixin `FailureMessageResolver` y muestra un snackbar con `AppLocalizations` cuando cambian; luego emite `UniversityDetailFeedbackDismissed`.
