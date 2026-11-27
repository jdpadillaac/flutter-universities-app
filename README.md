# Universities

App Flutter de universidades para la prueba de Tyba. El catálogo se descarga de S3. La lista pagina en local con scroll infinito y el detalle permite elegir una imagen y guardar el número de estudiantes durante la sesión. Plataformas: Android e iOS.

## Requisitos

- Flutter 3.50.1, fijado en `.fvmrc` (FVM).
- Conexión a internet para descargar `universities.json`.

## Ejecutar

```bash
fvm flutter run
```

Si cambias anotaciones de generación o los archivos ARB:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n
```

## Funcionalidades

- Catálogo Tyba desde S3.
- Vista de lista o cuadrícula.
- Scroll infinito de 20 ítems por página, sobre el catálogo ya cacheado.
- Detalle con país, dominio, sitio web y estado o provincia.
- Imagen desde cámara o galería (`image_picker`).
- Número de estudiantes con validación. Guardar queda deshabilitado si el valor no es válido.
- Estados de carga, vacío y error con reintento en la lista.
- Textos en español con `gen-l10n`.

## Arquitectura

Clean Architecture por feature. El dominio no importa Dio ni freezed.

```
lib/
  core/           red, Failure, tema, injectable, go_router
  features/universities/
    domain/       University, casos de uso, config de lista
    data/         remotos, DTOs, repositorios
    presentation/
      helpers/    texto de UI que usan dos o más pages
      pages/
        universities/       page, blocs y widgets de la lista
        university_detail/  page, bloc y widgets del detalle
```

## Decisiones

| Tema | Decisión |
|------|----------|
| Entidades | Equatable en dominio. Los DTO usan freezed y json_serializable, y no salen de data. |
| JSON | Se descarga como texto. `jsonDecode` y el mapeo corren en `Isolate.run`. |
| Errores | `Result` de oxidized. El único `try/catch` está en `ApiClient` y captura `DioException`. |
| Inyección | `injectable` y GetIt. `RegisterModule` registra Dio, GoRouter e ImagePicker. |
| Estado | Bloc en lista y detalle. `LayoutCubit` solo alterna lista y cuadrícula. |
| Paginación | Slice local del catálogo en memoria. `UniversitiesListConfig.pageSize` es 20. |
| Id | `UniversityIdGenerator`, porque el JSON no trae `id`. |
| Nombres | `HtmlEntityDecoder` resuelve entidades como `&amp;`. |
| Sesión | Imagen y número de estudiantes viven en memoria y se pierden al cerrar la app. |

## Permisos de cámara y galería

En iOS, `Info.plist` declara `NSCameraUsageDescription` y `NSPhotoLibraryUsageDescription`. En Android la app no declara `android.permission.CAMERA`: `image_picker` abre la galería con el Photo Picker del sistema y la cámara con un intent.

## Calidad

El coverage mínimo es 90%. El umbral y las exclusiones (`*.g.dart`, `*.freezed.dart`, `*.config.dart` y `lib/main.dart`) están en `very_good.yaml`. CI usa los mismos comandos:

```bash
very_good packages get
dart format --set-exit-if-changed .
fvm flutter analyze
very_good test --coverage --min-coverage 90
```

## Con más tiempo

- Persistir imagen y conteo entre sesiones.
- Filtrar y buscar por nombre o país.
- Modo oscuro y más locales.
- Golden tests de las pantallas principales.
- Pipelines de release firmados (TestFlight y Play Internal).
