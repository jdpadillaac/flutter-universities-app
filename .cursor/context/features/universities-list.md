# Lista de universidades

Page, blocs y widgets: `lib/features/universities/presentation/pages/universities/`.

`UniversitiesPage` usa `UniversitiesBloc` y `UniversityThumbnailsBloc`. El catálogo vive en `UniversitiesScrollView` (scroll infinito con `UniversitiesListConfig`).

Estados: carga centrada, vacío, error con Reintentar, lista o cuadrícula con `LoadMoreIndicator` y banner de error con ítems ya cargados.

Ítems: `UniversityListTile` y `UniversityGridCard` con `UniversityAvatar` (imagen de sesión o iniciales vía `UniversityInitialsResolver`). Tap navega al detalle con `go_router`.

Para alternar lista/cuadrícula, ver `layout-toggle.md`.