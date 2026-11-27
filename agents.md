# Universities

App Flutter de universidades con Clean Architecture por feature. El JSON vive en S3. La presentación es un placeholder de lista y detalle. Plataformas: Android e iOS.

## Arranque

```bash
fvm flutter run
```

Para regenerar freezed, json_serializable e injectable:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

## Mapa

- `lib/core/`: red, errores, utilidades, inyección, router y tema.
- `lib/features/universities/domain/`: entidades, contrato del repositorio, generador de id y casos de uso.
- `lib/features/universities/data/`: DTOs, mapper, parser, data source remoto y repositorio con caché.
- `lib/features/universities/presentation/`: lista y detalle.

## Comandos

```bash
very_good packages get
fvm dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
fvm flutter analyze
very_good test --coverage --min-coverage 90
```

## Calidad

El coverage global tiene que ser al menos 90%, sin contar `**/*.g.dart`, `**/*.freezed.dart`, `**/*.config.dart` ni `lib/main.dart`. Lo verifican `very_good.yaml`, el hook `stop` y el workflow de CI.

## Idioma

Responder siempre en español, incluidos los planes. Código, identificadores y comentarios en inglés.

## Para otros chats

Leer `.cursor/context/project.md` y `.cursor/context/features/` antes de asumir que algo existe.
