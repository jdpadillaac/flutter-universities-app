# Lista de universidades

`UniversitiesPage` usa `UniversitiesBloc`, `LayoutCubit` y `UniversityThumbnailsBloc`. Carga la página 0 al abrir, scroll infinito con `ScrollController` (~200 px antes del final) y alterna lista/grid desde el `AppBar`.

Switch exhaustivo sobre `UniversitiesState`: loading, failure vacío con Reintentar, failure con ítems, vacío y cargado con footer de carga.

Ítems reutilizables: `UniversityListTile` y `UniversityGridCard` con miniatura desde extras de sesión. Tap navega con `go_router` al detalle por id.