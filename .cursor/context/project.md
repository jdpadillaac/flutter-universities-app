# Proyecto

App Flutter `universities_app` de universidades. Clean Architecture por feature. Plataformas: Android e iOS.

El catálogo es un JSON en S3: `https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json`.

## Campos del JSON

Cada objeto trae `name`, `country`, `alpha_two_code`, `domains`, `web_pages` y `state-province`. No hay `id`. La clave de provincia usa guion y casi siempre es `null`. Algunos nombres traen `&` como entidad HTML, por ejemplo `&amp;`.

## Stack

Flutter 3.50.1, Dio, oxidized, injectable con GetIt, go_router, flutter_bloc, freezed y json_serializable solo en el DTO, Equatable en las entidades, `image_picker` detrás de `ImagePickerService`. El análisis usa `very_good_analysis`. Los tests y el coverage usan Very Good CLI con mínimo 90%.

## Decisiones

- El dominio no depende de freezed, json ni data.
- `ApiClient` es el único `try/catch` de `lib/` y solo captura `DioException`.
- El parseo corre en `Isolate.run`.
- No hay plataforma web.
- No hay comentarios en `lib/` ni en `test/`.
- `configureDependencies` sigue siendo una función top-level porque `@InjectableInit` solo se puede poner en funciones.
