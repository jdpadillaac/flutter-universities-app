# Lista de universidades

`UniversitiesPage` usa `UniversitiesBloc`, `LayoutCubit` y `UniversityThumbnailsBloc`. `UniversitiesHeader` y `LayoutToggle` alternan lista/cuadrícula. El catálogo vive en `UniversitiesScrollView` (scroll infinito, umbral 200 px).

Estados: carga centrada, vacío, error con Reintentar, lista/cuadrícula con `LoadMoreIndicator` y banner de error con ítems ya cargados.

Ítems: `UniversityListTile` y `UniversityGridCard` con `UniversityAvatar` (imagen de sesión o iniciales vía `UniversityInitialsResolver`). Tap navega al detalle con `go_router`.