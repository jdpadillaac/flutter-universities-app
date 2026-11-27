import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';

extension StudentCountErrorMessages on StudentCountError {
  String get message {
    return switch (this) {
      StudentCountError.empty => 'Ingresa un número de estudiantes.',
      StudentCountError.notANumber => 'El valor debe ser un número entero.',
      StudentCountError.mustBePositive => 'El valor debe ser mayor que cero.',
      StudentCountError.tooLarge => 'El valor no puede superar 1.000.000.',
    };
  }
}
