# Selector de imagen

`ImagePickerService` en `lib/core/media/` abstrae cámara y galería. `ImagePickerServiceImpl` usa `image_picker` vía `ImagePicker` registrado en `RegisterModule`.

Resultados: `ImagePicked`, `ImagePickCancelled`, `ImagePickPermissionDenied`, `ImagePickFailed`.

`UniversityDetailBloc` llama al servicio y, si hay archivo, guarda la ruta con `SaveUniversityImage` de inmediato.

iOS: `NSCameraUsageDescription` y `NSPhotoLibraryUsageDescription` en `Info.plist`. Android: `<queries>` con `IMAGE_CAPTURE`; no declarar `CAMERA` en el manifiesto.