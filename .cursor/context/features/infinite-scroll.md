# Scroll infinito

`UniversitiesScrollView`: `lib/features/universities/presentation/pages/universities/widgets/universities_scroll_view.dart`.

La paginación sigue en `GetUniversitiesPage` y `UniversitiesBloc`. El `ScrollController` vive solo en `UniversitiesScrollView` y dispara `UniversitiesNextPageRequested` cerca del final.