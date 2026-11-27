# Conteo de estudiantes

`StudentCountCard` y `StudentCountField`: `lib/features/universities/presentation/pages/university_detail/widgets/`. `StudentCountErrorMessage`: `pages/university_detail/student_count_error_message.dart`.

`StudentCount` vive en `lib/features/universities/domain/value_objects/student_count.dart`. El máximo permitido es `1_000_000` (`StudentCount.max`).

`StudentCountError`: `empty`, `notANumber`, `mustBePositive`, `tooLarge`. Solo enteros, mayor que cero y como máximo el límite anterior. Los errores se muestran en detalle solo tras interactuar con el campo.

`UniversityDetailBloc` valida con `StudentCount.parse`. El botón Guardar persiste el conteo en `UniversityExtrasRepository`; la imagen se guarda al elegirla, sin pasar por Guardar.