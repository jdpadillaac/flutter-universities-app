# Proyecto

App Flutter `universities_app` de universidades. Clean Architecture por feature. Plataformas: Android e iOS. No hay web.

El catálogo es un JSON en S3: `https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json`.

## Campos del JSON

Cada objeto trae `name`, `country`, `alpha_two_code`, `domains`, `web_pages` y `state-province`. No hay `id`. La clave de provincia usa guion y casi siempre es `null`. Algunos nombres traen `&` como entidad HTML, por ejemplo `&amp;`.

La entidad `University` guarda `id` generado, `name` ya decodificado, `country`, `countryCode` (`alpha_two_code`), `stateProvince`, `domains` y `webPages`.

## Stack

Flutter 3.50.1, Dio, oxidized, injectable con GetIt, go_router, flutter_bloc, freezed y json_serializable solo en el DTO, Equatable en las entidades, `image_picker` detrás de `ImagePickerRepository` en data. El análisis usa `very_good_analysis`. Los tests y el coverage usan Very Good CLI con mínimo 90% (`very_good.yaml`).

## Navegación

`GoRouter` se construye en `RegisterModule`. `AppRoutes.list` es `/` y muestra `UniversitiesPage` con `NoTransitionPage`. El detalle es hijo: `universities/:id`, nombre `university-detail`, sobre el navigator raíz. `UniversityDetailPage` recibe el `id` del path.

## Casos de uso

- `GetUniversitiesPage`: pide el catálogo y devuelve un `UniversitiesSliceEntity` (`items` y `hasReachedMax`).
- `GetUniversityById`: busca por `id` en ese catálogo. Si no está, `NotFoundFailure`.
- `GetUniversityExtras` y `GetAllUniversityExtras`: leen imagen y conteo de la sesión.
- `SaveUniversityImage` y `SaveUniversityStudentCount`: escriben en `UniversityExtrasRepository`.
- `PickUniversityImage`: único acceso a cámara o galería desde el bloc de detalle.

## Decisiones

- El dominio no depende de freezed, json ni data.
- `ApiClient` es el único `try/catch` de `lib/` y solo captura `DioException`.
- El parseo corre en `Isolate.run`.
- Imagen y conteo viven en memoria y se pierden al cerrar la app.
- No hay comentarios en `lib/` ni en `test/`.
- `configureDependencies` sigue siendo una función top-level porque `@InjectableInit` solo se puede poner en funciones.

## Dónde leer

- `features/data-loading.md`: descarga, parseo, caché e ids.
- `features/universities-list.md`: pantalla de lista.
- `features/infinite-scroll.md`: paginación local.
- `features/layout-toggle.md`: lista o cuadrícula.
- `features/university-detail.md`: pantalla de detalle.
- `features/student-count.md`: validación y Guardar.
- `features/image-picker.md`: cámara, galería y permisos.
- `design-system.md`: tokens y widgets de UI.

`README.md` es el resumen para quien revisa la prueba. El comportamiento de la app vive en estos archivos.
