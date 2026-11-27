# Scroll infinito

`GetUniversitiesPage` recorta en memoria la lista que devuelve el repositorio. La página empieza en 0 y el tamaño por defecto es 20. Si el inicio queda fuera de la lista, la página llega vacía y `hasReachedMax` es true.

`page < 0` devuelve `UnexpectedFailure` con mensaje `page must be >= 0`. `pageSize <= 0` devuelve `UnexpectedFailure` con mensaje `pageSize must be > 0`. Esas llamadas no tocan el repositorio.

La UI de scroll infinito vive en `UniversitiesListPage` y usa `UniversitiesBloc`.
