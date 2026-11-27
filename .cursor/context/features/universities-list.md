# Lista de universidades

`UniversitiesListPage` usa `UniversitiesBloc` y `LayoutCubit`. Carga la página 0 al abrir, pide más páginas al llegar al final del scroll y permite alternar lista y grid desde el `AppBar`.

Cada ítem abre el detalle con el id de la universidad. Si falla una carga inicial, muestra error y Retry. Si falla un append, conserva los ítems y muestra el error abajo con Retry.
