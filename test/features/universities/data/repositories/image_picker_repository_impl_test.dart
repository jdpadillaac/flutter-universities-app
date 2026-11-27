import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/data/repositories/image_picker_repository_impl.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';

class MockImagePicker extends Mock implements ImagePicker {}

class FakeXFile extends Fake implements XFile {
  FakeXFile(this.path);

  @override
  final String path;
}

void main() {
  late MockImagePicker picker;
  late ImagePickerRepositoryImpl repository;

  setUp(() {
    picker = MockImagePicker();
    repository = ImagePickerRepositoryImpl(picker);
  });

  test('returns Ok with path when a file is selected', () async {
    when(
      () => picker.pickImage(source: ImageSource.gallery),
    ).thenAnswer((_) async => FakeXFile('/tmp/photo.jpg'));

    final result = await repository.pick(ImageOrigin.gallery);

    expect(result, const Ok<String?, Failure>('/tmp/photo.jpg'));
  });

  test('returns Ok with null when the user cancels', () async {
    when(
      () => picker.pickImage(source: ImageSource.camera),
    ).thenAnswer((_) async => null);

    final result = await repository.pick(ImageOrigin.camera);

    expect(result, const Ok<String?, Failure>(null));
  });

  test('returns PermissionDeniedFailure for permission errors', () async {
    when(
      () => picker.pickImage(source: ImageSource.camera),
    ).thenThrow(PlatformException(code: 'camera_access_denied'));

    final result = await repository.pick(ImageOrigin.camera);

    expect(result, const Err<String?, Failure>(PermissionDeniedFailure()));
  });

  test('returns CameraUnavailableFailure when camera is missing', () async {
    when(
      () => picker.pickImage(source: ImageSource.camera),
    ).thenThrow(PlatformException(code: 'no_available_camera'));

    final result = await repository.pick(ImageOrigin.camera);

    expect(result, const Err<String?, Failure>(CameraUnavailableFailure()));
  });

  test('returns UnexpectedFailure for other platform errors', () async {
    when(
      () => picker.pickImage(source: ImageSource.gallery),
    ).thenThrow(PlatformException(code: 'unknown', message: 'broken'));

    final result = await repository.pick(ImageOrigin.gallery);

    expect(result, isA<Err<String?, Failure>>());
    expect((result as Err).error, isA<UnexpectedFailure>());
  });
}
