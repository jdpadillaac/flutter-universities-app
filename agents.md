# Universities

App Flutter de universidades con Clean Architecture por feature. El JSON vive en S3. La presentación todavía es un placeholder de lista y detalle.

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
- `lib/features/universities/domain/`: entidades, contrato del repositorio y casos de uso.
- `lib/features/universities/data/`: modelos, data source remoto y repositorio con caché.
- `lib/features/universities/presentation/`: lista y detalle.

## Comandos

```bash
fvm flutter analyze
tool/coverage.sh
```

## Calidad

El coverage global tiene que ser al menos 90%, sin contar archivos generados ni `lib/main.dart`. Lo verifican el hook `stop` y el workflow de CI.

## Idioma

Responder siempre en español, incluidos los planes. Código, identificadores y comentarios en inglés.

## Para otros chats

Leer `.cursor/context/funcionalidades.md` antes de asumir que algo existe.
