# Universities

App Flutter de universidades para la prueba de Tyba. Catálogo desde S3, lista con scroll infinito, detalle con imagen (cámara o galería) y número de estudiantes en memoria durante la sesión. Plataformas: Android e iOS.

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

## Permisos de cámara y galería

- **iOS:** `NSCameraUsageDescription` y `NSPhotoLibraryUsageDescription` en `ios/Runner/Info.plist`.
- **Android:** no se declara `android.permission.CAMERA`. Con `image_picker` 1.x la galería usa el Photo Picker del sistema; el plugin aporta `FileProvider` y el backport de GMS (`photopicker_activity`). La cámara se lanza por intent. En la app solo hay `<queries>` de `IMAGE_CAPTURE` para visibilidad en Android 11+. Añadir `CAMERA` obligaría al runtime a pedirlo sin mejorar el flujo actual.

## ¿Por qué Very Good CLI?

- **Comandos del equipo.** `very_good packages get` y `very_good test` concentran el flujo que usan CI y el hook, en lugar de scripts propios.
- **Tests optimizados y coverage mínimo.** `very_good test` agrupa la suite para correrla más rápido y `very_good.yaml` fija el mínimo en 90%.
- **`packages get` recursivo.** `very_good packages get` resuelve dependencias del paquete y de los paquetes anidados.
- **Coherencia con `very_good_analysis` y VGV.** El análisis ya usa `very_good_analysis`. La CLI alinea tests, coverage y estilo con Very Good Ventures.