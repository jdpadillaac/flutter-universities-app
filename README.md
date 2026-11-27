# Universities

App Flutter de universidades. Clean Architecture por feature, catálogo JSON en S3 y pantallas placeholder de lista y detalle. Plataformas: Android e iOS.

## Comandos

```bash
very_good packages get
fvm dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
fvm flutter analyze
very_good test --coverage --min-coverage 90
fvm flutter run
```

El umbral de coverage y las exclusiones viven en `very_good.yaml`.

## ¿Por qué Very Good CLI?

- **Comandos del equipo.** `very_good packages get` y `very_good test` concentran el flujo que usan CI y el hook, en lugar de scripts propios.
- **Tests optimizados y coverage mínimo.** `very_good test` agrupa la suite para correrla más rápido y `very_good.yaml` fija el mínimo en 90%.
- **`packages get` recursivo.** `very_good packages get` resuelve dependencias del paquete y de los paquetes anidados.
- **Coherencia con `very_good_analysis` y VGV.** El análisis ya usa `very_good_analysis`. La CLI alinea tests, coverage y estilo con Very Good Ventures.
