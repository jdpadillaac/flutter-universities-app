# Selector de imagen

`UniversityImagePicker`, `ImageSourceSheet` y `DashedBorderPainter`: `lib/features/universities/presentation/pages/university_detail/widgets/`.

Sin imagen, los botones de cámara y galería emiten `UniversityImagePickRequested` directo. Con imagen, Cambiar abre `ImageSourceSheet.show`, que devuelve `ImageOrigin?`. Si el sheet se cierra sin elegir, no hay evento.

`ImageOrigin` vive en dominio (`camera`, `gallery`). `PickUniversityImage` es el único punto de entrada desde `UniversityDetailBloc`. `ImagePickerRepository.pick` devuelve `Result<String?, Failure>`. `null` es cancelación: el bloc no guarda nada. Un path se persiste al momento con `SaveUniversityImage`.

`ImagePickerRepositoryImpl` traduce `PlatformException`: `camera_access_denied` y `photo_access_denied` son `PermissionDeniedFailure`; `no_available_camera` es `CameraUnavailableFailure`; el resto es `UnexpectedFailure`. El fallo llega como `imageFailure` y la page lo muestra en un snackbar.

Android: el manifiesto de la app no declara `CAMERA`. Solo hay `<queries>` de `IMAGE_CAPTURE`. iOS: `NSCameraUsageDescription` y `NSPhotoLibraryUsageDescription` en `Info.plist`.
