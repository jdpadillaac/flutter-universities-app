# Selector de imagen

`ImageOrigin` vive en dominio. `ImagePickerRepository` devuelve `Result<String?, Failure>`; `ImagePickerRepositoryImpl` en data traduce a `image_picker` y los códigos de `PlatformException`.

`PickUniversityImage` es el único punto de entrada desde `UniversityDetailBloc`. `ImageSourceSheet.show` devuelve `ImageOrigin?` para cámara o galería.

Android: sin `CAMERA` en el manifiesto de la app; `<queries>` de `IMAGE_CAPTURE` en `AndroidManifest.xml`. iOS: textos de uso en `Info.plist`. Detalle en README.