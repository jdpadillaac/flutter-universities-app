# Scroll infinito

`UniversitiesScrollView`: `lib/features/universities/presentation/pages/universities/widgets/universities_scroll_view.dart`.

`GetUniversitiesPage` corta el catálogo ya cacheado. `UniversitiesListConfig.pageSize` es 20. `loadMoreThreshold` es 200: si `extentAfter` baja de eso, el scroll view emite `UniversitiesNextPageRequested`.

`UniversitiesBloc` ignora esa petición si no está en `UniversitiesLoaded`, si ya está cargando o si `hasReachedMax`. La página siguiente se concatena a los ítems actuales. Un error de la primera página deja la lista vacía. Un error de una página posterior conserva los ítems y muestra el banner.

El `ScrollController` vive solo en `UniversitiesScrollView`.
