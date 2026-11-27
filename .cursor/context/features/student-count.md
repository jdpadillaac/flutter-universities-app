# Conteo de estudiantes

`StudentCountCard` y `StudentCountField`: `lib/features/universities/presentation/pages/university_detail/widgets/`. `StudentCountErrorMessage`: `pages/university_detail/student_count_error_message.dart`.

`StudentCount` vive en `lib/features/universities/domain/value_objects/student_count.dart`. El máximo permitido es `1000000` (`StudentCount.max`).

`StudentCountError`: `empty`, `notANumber`, `mustBePositive`, `tooLarge`. Solo enteros, mayor que cero y como máximo el límite anterior.

El campo usa `FilteringTextInputFormatter.digitsOnly`. `UniversityDetailBloc` valida con `StudentCount.parse` en cada cambio. El error que ve el usuario es `visibleError`, y solo existe si `studentsTouched` es true. Guardar usa `isValid` (parse correcto y texto no vacío) y persiste en `UniversityExtrasRepository`. La imagen se guarda al elegirla, sin pasar por Guardar. Un guardado correcto pone `StudentCountSaveStatus.saved` y la page muestra el snackbar de éxito.
