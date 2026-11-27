import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/features/universities/domain/usecases/get_university_by_id.dart';
import 'package:universities_app/features/universities/domain/usecases/get_university_extras.dart';
import 'package:universities_app/features/universities/domain/usecases/pick_university_image.dart';
import 'package:universities_app/features/universities/domain/usecases/save_university_image.dart';
import 'package:universities_app/features/universities/domain/usecases/save_university_student_count.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/bloc/university_detail_bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/bloc/university_detail_bloc/university_detail_state.dart';

@injectable
class UniversityDetailBloc
    extends Bloc<UniversityDetailEvent, UniversityDetailState> {
  UniversityDetailBloc(
    this._getUniversityById,
    this._getUniversityExtras,
    this._saveUniversityImage,
    this._saveUniversityStudentCount,
    this._pickUniversityImage,
  ) : super(UniversityDetailLoading()) {
    on<UniversityDetailRequested>(_onDetailRequested);
    on<UniversityStudentsChanged>(_onStudentsChanged);
    on<UniversityImagePickRequested>(_onImagePickRequested);
    on<UniversityStudentsSaveRequested>(_onStudentsSaveRequested);
    on<UniversityDetailFeedbackDismissed>(_onFeedbackDismissed);
  }

  final GetUniversityById _getUniversityById;
  final GetUniversityExtras _getUniversityExtras;
  final SaveUniversityImage _saveUniversityImage;
  final SaveUniversityStudentCount _saveUniversityStudentCount;
  final PickUniversityImage _pickUniversityImage;

  String? _universityId;

  Future<void> _onDetailRequested(
    UniversityDetailRequested event,
    Emitter<UniversityDetailState> emit,
  ) async {
    _universityId = event.universityId;
    emit(UniversityDetailLoading());

    final universityId = event.universityId;
    if (universityId == null) {
      emit(UniversityDetailNotFound());
      return;
    }

    final result = await _getUniversityById(universityId);

    switch (result) {
      case Ok(value: final university):
        final extras = _getUniversityExtras(universityId);
        final studentsInput = extras.studentCount?.value.toString() ?? '';
        final validation = StudentCount.parse(studentsInput);

        emit(
          UniversityDetailLoaded(
            university: university,
            imagePath: extras.imagePath,
            studentsInput: studentsInput,
            validationError: _validationError(validation),
          ),
        );
      case Err():
        emit(UniversityDetailNotFound());
    }
  }

  void _onStudentsChanged(
    UniversityStudentsChanged event,
    Emitter<UniversityDetailState> emit,
  ) {
    final current = state;
    if (current is! UniversityDetailLoaded) {
      return;
    }

    final validation = StudentCount.parse(event.value);
    emit(
      current.copyWith(
        studentsInput: event.value,
        studentsTouched: true,
        validationError: _validationError(validation),
        clearValidationError: validation.isOk(),
      ),
    );
  }

  StudentCountError? _validationError(
    Result<StudentCount, StudentCountError> validation,
  ) {
    return switch (validation) {
      Ok() => null,
      Err(:final error) => error,
    };
  }

  Future<void> _onImagePickRequested(
    UniversityImagePickRequested event,
    Emitter<UniversityDetailState> emit,
  ) async {
    final universityId = _universityId;
    final current = state;
    if (universityId == null || current is! UniversityDetailLoaded) {
      return;
    }

    final result = await _pickUniversityImage(event.origin);

    switch (result) {
      case Ok(value: final path):
        if (path == null) {
          return;
        }
        _saveUniversityImage(universityId: universityId, imagePath: path);
        emit(current.copyWith(imagePath: path, clearImageFailure: true));
      case Err(:final error):
        emit(current.copyWith(imageFailure: error));
    }
  }

  void _onStudentsSaveRequested(
    UniversityStudentsSaveRequested event,
    Emitter<UniversityDetailState> emit,
  ) {
    final universityId = _universityId;
    final current = state;
    if (universityId == null || current is! UniversityDetailLoaded) {
      return;
    }
    if (!current.isValid) {
      return;
    }

    final parsed = StudentCount.parse(current.studentsInput);
    if (parsed case Ok(value: final count)) {
      _saveUniversityStudentCount(
        universityId: universityId,
        studentCount: count,
      );
      emit(
        current.copyWith(
          saveStatus: StudentCountSaveStatus.saved,
          clearValidationError: true,
        ),
      );
    }
  }

  void _onFeedbackDismissed(
    UniversityDetailFeedbackDismissed event,
    Emitter<UniversityDetailState> emit,
  ) {
    final current = state;
    if (current is! UniversityDetailLoaded) {
      return;
    }
    emit(
      current.copyWith(
        saveStatus: StudentCountSaveStatus.idle,
        clearImageFailure: true,
      ),
    );
  }
}
