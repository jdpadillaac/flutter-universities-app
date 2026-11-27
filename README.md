# Universities

App Flutter de universidades para la prueba de Tyba. Catálogo desde S3, lista con scroll infinito, detalle con imagen (cámara o galería) y número de estudiantes en memoria durante la sesión. Plataformas: Android e iOS.

## Funcionalidades

- Descarga del catálogo Tyba (`universities.json` en S3).
- Lista con alternancia **lista / cuadrícula**.
- Scroll infinito de **20 ítems** por página, sin librerías externas de paginación.
- Detalle con país, dominio, sitio web y estado/provincia.
- Imagen por **cámara** o **galería** (`image_picker`).
- Número de estudiantes con validación y botón Guardar deshabilitado si el valor no es válido.
- Estados de carga, vacío y error con reintento en la lista.
- Textos en español vía `gen-l10n` (ARB).

## Comandos

```bash
very_good packages get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n
dart format --set-exit-if-changed .
fvm flutter analyze
very_good test --coverage --min-coverage 90
fvm flutter run
```

El umbral de coverage y las exclusiones viven en `very_good.yaml`.

## Arquitectura

```
┌─────────────────────────────────────────────────────────┐
│                    presentation                         │
│  UniversitiesPage, UniversityDetailPage, widgets, Bloc │
└───────────────────────────┬─────────────────────────────┘
                            │ casos de uso
┌───────────────────────────▼─────────────────────────────┐
│                      domain                             │
│  entities, StudentCount, repositorios (contratos), UC   │
└───────────────────────────┬─────────────────────────────┘
                            │ implementaciones
┌───────────────────────────▼─────────────────────────────┐
│                       data                              │
│  DTOs (freezed), mapper, parser (isolate), repos, API     │
└───────────────────────────┬─────────────────────────────┘
                            │
┌───────────────────────────▼─────────────────────────────┐
│                       core                              │
│  red, errores, tema, DI, router, utilidades              │
└─────────────────────────────────────────────────────────┘
```

```
lib/
  core/           red, Failure, tema, injectable, go_router
  features/universities/
    domain/       University, casos de uso, config de lista
    data/         remotos, DTOs, repositorios
    presentation/ páginas, widgets, bloc/cubit
```

## Decisiones técnicas

| Tema | Decisión |
|------|----------|
| Capas | Clean Architecture por feature; el dominio no importa Dio ni freezed. |
| Entidades | Equatable en dominio; DTO con freezed + json_serializable solo en data. |
| JSON | Descarga como texto; `jsonDecode` y mapeo en `Isolate.run`. |
| Errores | `Result` (oxidized); un solo `try/catch` en `ApiClient` (Dio). |
| DI | `injectable` + GetIt; `RegisterModule` para Dio, GoRouter e ImagePicker. |
| Estado UI | Bloc con estados sellados en detalle y lista; `LayoutCubit` para el toggle. |
| Widgets | Stateless por defecto; `ScrollController` y `TextEditingController` solo donde hace falta. |
| Tema | Tokens en `lib/core/theme/` (Opción A). |
| Paginación | Slice local sobre el catálogo cacheado; `UniversitiesListConfig.pageSize = 20`. |
| Id | Generado con `UniversityIdGenerator` (el JSON no trae `id`). |
| Nombres HTML | `HtmlEntityDecoder` para `&amp;` y entidades similares. |
| Sesión | `UniversityExtrasRepository` en memoria (imagen y conteo no persisten al cerrar la app). |
| StudentCount | El campo filtra dígitos; el dominio también valida vacío, cero, no numérico y máximo. |
| Imágenes | `ImageOrigin` en dominio; `ImagePickerRepository` en data; `PickUniversityImage` en el bloc. |
| Android permisos | Sin `CAMERA` en el manifiesto de la app; ver sección siguiente. |

## Permisos de cámara y galería

- **iOS:** `NSCameraUsageDescription` y `NSPhotoLibraryUsageDescription` en `ios/Runner/Info.plist`.
- **Android:** no se declara `android.permission.CAMERA`. Con `image_picker` 1.x la galería usa el Photo Picker del sistema; el plugin aporta `FileProvider` y el backport de GMS (`photopicker_activity`). La cámara se lanza por intent. En la app solo hay `<queries>` de `IMAGE_CAPTURE` para visibilidad en Android 11+. Añadir `CAMERA` obligaría al runtime a pedirlo sin mejorar el flujo actual.

## ¿Por qué Very Good CLI?

- **Comandos del equipo.** `very_good packages get` y `very_good test` alinean local, CI y hook.
- **Tests y coverage.** Suite optimizada y umbral mínimo del 90% en `very_good.yaml`.
- **`packages get` recursivo** para paquetes anidados.
- **Coherencia** con `very_good_analysis` y prácticas VGV.

## Tests y cobertura

```bash
very_good test --coverage --min-coverage 90
```

Suite con tests unitarios, de bloc y de widgets (mocktail). Tras la última corrida local, el coverage global ronda el **91%** (excluye `*.g.dart`, `*.freezed.dart`, `*.config.dart` y `lib/main.dart`).

## Qué haría con más tiempo

- Persistencia local (Hive/Isar) para imagen y conteo entre sesiones.
- Filtro y búsqueda por nombre o país.
- Modo oscuro y más locales.
- Golden tests de las pantallas principales.
- Pipelines de release firmados y distribución (TestFlight / Play Internal).

## Capturas

| Pantalla | Vista |
|----------|-------|
| Lista (list) | pendiente |
| Lista (grid) | pendiente |
| Detalle | pendiente |
| Error de red | pendiente |

## Repositorio

Código en [github.com/jdpadillac/flutter-universities-app](https://github.com/jdpadillac/flutter-universities-app). Rama de entrega: `feat/design-option-a-clear-ui` (PR #8).