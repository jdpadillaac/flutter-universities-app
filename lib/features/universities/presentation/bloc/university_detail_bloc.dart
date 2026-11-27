import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/media/image_picker_service.dart';
import 'package:universities_app/features/universities/domain/usecases/get_university_by_id.dart';
import 'package:universities_app/features/universities/domain/usecases/get_university_extras.dart';
import 'package:universities_app/features/universities/domain/usecases/save_university_image.dart';
import 'package:universities_app/features/universities/domain/usecases/save_university_student_count.dart';
import 'package:universities_app/features/universities/domain/value_objects/student_count.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';

@injectable
class UniversityDetailBloc
    extends Bloc<UniversityDetailEvent, UniversityDetailState> {
  UniversityDetailBloc(
    this._getUniversityById,
    this._getUniversityExtras,
    this._saveUniversityImage,
    this._saveUniversityStudentCount,
    this._imagePickerService,
  ) : super(const UniversityDetailState()) {
    on<UniversityDetailRequested>(_onDetailRequested);
    on<UniversityStudentsChanged>(_onStudentsChanged);
    on<UniversityImagePickRequested>(_onImagePickRequested);
    on<UniversityStudentsSaveRequested>(_onStudentsSaveRequested);
    on<UniversityDetailNoticeShown>(_onNoticeShown);
  }

  final GetUniversityById _getUniversityById;
  final GetUniversityExtras _getUniversityExtras;
  final SaveUniversityImage _saveUniversityImage;
  final SaveUniversityStudentCount _saveUniversityStudentCount;
  final ImagePickerService _imagePickerService;

  String? _universityId;

  Future<void> _onDetailRequested(
    UniversityDetailRequested event,
    Emitter<UniversityDetailState> emit,
  ) async {
    _universityId = event.universityId;
    emit(const UniversityDetailState());

    final universityId = event.universityId;
    if (universityId == null) {
      emit(
        const UniversityDetailState(status: UniversityDetailStatus.notFound),
      );
      return;
    }

    final result = await _getUniversityById(universityId);

    switch (result) {
      case Ok(value: final university):
        final extras = _getUniversityExtras(universityId);
        final studentsInput = extras.studentCount?.value.toString() ?? '';
        final validation = StudentCount.parse(studentsInput);

        emit(
          UniversityDetailState(
            status: UniversityDetailStatus.ready,
            university: university,
            imagePath: extras.imagePath,
            studentsInput: studentsInput,
            validationError: _validationError(validation),
          ),
        );
      case Err():
        emit(
          const UniversityDetailState(status: UniversityDetailStatus.notFound),
        );
    }
  }

  void _onStudentsChanged(
    UniversityStudentsChanged event,
    Emitter<UniversityDetailState> emit,
  ) {
    final validation = StudentCount.parse(event.value);
    emit(
      state.copyWith(
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
    if (universityId == null) {
      return;
    }

    final result = await _imagePickerService.pick(event.source);

    switch (result) {
      case ImagePicked(:final path):
        _saveUniversityImage(universityId: universityId, imagePath: path);
        emit(state.copyWith(imagePath: path, clearImageFailedMessage: true));
      case ImagePickCancelled():
        break;
      case ImagePickPermissionDenied():
        emit(
          state.copyWith(
            notice: UniversityDetailNotice.permissionDenied,
            clearImageFailedMessage: true,
          ),
        );
      case ImagePickFailed(:final message):
        emit(
          state.copyWith(
            notice: UniversityDetailNotice.imageFailed,
            imageFailedMessage: message,
          ),
        );
    }
  }

  void _onStudentsSaveRequested(
    UniversityStudentsSaveRequested event,
    Emitter<UniversityDetailState> emit,
  ) {
    final universityId = _universityId;
    if (universityId == null || !state.isFormValid) {
      return;
    }

    final parsed = StudentCount.parse(state.studentsInput);
    if (parsed case Ok(value: final count)) {
      _saveUniversityStudentCount(
        universityId: universityId,
        studentCount: count,
      );
      emit(
        state.copyWith(
          notice: UniversityDetailNotice.saved,
          clearValidationError: true,
        ),
      );
    }
  }

  void _onNoticeShown(
    UniversityDetailNoticeShown event,
    Emitter<UniversityDetailState> emit,
  ) {
    emit(
      state.copyWith(
        notice: UniversityDetailNotice.none,
        clearImageFailedMessage: true,
      ),
    );
  }
}
