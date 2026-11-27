# Lista de universidades

Page, blocs y widgets: `lib/features/universities/presentation/pages/universities/`.

`UniversitiesPage` crea `UniversitiesBloc` (dispara `UniversitiesRequested`), `LayoutCubit` y `UniversityThumbnailsBloc` (dispara `UniversityThumbnailsRequested`).

El bloc acumula páginas. `UniversitiesScrollView` pinta los ítems que ya llegaron y pide la siguiente cerca del final. El tamaño de página está en `UniversitiesListConfig`.

Estados de `UniversitiesBloc`:

- `UniversitiesInitial` y `UniversitiesLoading`: `UniversitiesLoadingState`.
- `UniversitiesLoaded` vacío: `UniversitiesEmptyState`.
- `UniversitiesLoaded` con ítems: lista o cuadrícula; `LoadMoreIndicator` si `isLoadingMore`.
- `UniversitiesFailure` sin ítems: `UniversitiesFailureState` con Reintentar.
- `UniversitiesFailure` con ítems: la lista sigue visible y debajo va `UniversitiesInlineFailureBanner`.

Ítems: `UniversityListTile` y `UniversityGridCard` con `UniversityAvatar` (imagen de sesión o iniciales vía `UniversityInitialsResolver`). El tap hace `context.push` a `/universities/$id`. Al volver, el scroll view vuelve a pedir `UniversityThumbnailsRequested`. `UniversityThumbnailsBloc` lee `GetAllUniversityExtras` y publica solo los `imagePath` no nulos.

Para alternar lista o cuadrícula, ver `layout-toggle.md`.
