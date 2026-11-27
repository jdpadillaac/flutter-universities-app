# Funcionalidades

App Flutter de universidades (`universities_app`). Android, iOS y web. Clean Architecture por feature.

## Lista y detalle

La presentación es un placeholder.

- `UniversitiesListPage` muestra el título Universities y un botón que abre el detalle de ejemplo (`sample`).
- `UniversityDetailPage` muestra el id recibido por la ruta `/universities/:id`.
- El router está en `lib/core/router/`. El tema claro y oscuro está en `lib/core/theme/`.

## Datos de universidades

El JSON vive en S3: `https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json`.

- `GetUniversitiesPage` pide la página (empieza en 1, tamaño 20) y recorta la lista en memoria.
- `UniversitiesRepositoryImpl` guarda la lista en memoria. Un error no se cachea.
- `UniversitiesRemoteDataSourceImpl` descarga el cuerpo como texto y lo parsea con `compute`.
- Cada universidad tiene un id estable a partir del nombre y del primer dominio. Los nombres decodifican entidades HTML (`&amp;` y el resto de referencias que cubre `decodeHtmlEntities`).

## Calidad

- `tool/coverage.sh` corre los tests y exige al menos 90% de coverage global, sin generados ni `lib/main.dart`.
- El hook `stop` de `.cursor/hooks.json` corre esa comprobación cuando cambia algún `.dart` de `lib/` o `test/`.
- El workflow `.github/workflows/ci.yml` corre analyze, format y el mismo umbral de coverage.

## Qué no hay

No hay búsqueda, filtros, autenticación ni paginación en el servidor. Si no aparece aquí, no está implementado.
