import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:universities_app/core/media/image_picker_service.dart';
import 'package:universities_app/core/media/image_picker_service_impl.dart';

class MockImagePicker extends Mock implements ImagePicker {}

class _FakeXFile extends Fake implements XFile {
  _FakeXFile(this.path);

  @override
  final String path;
}

void main() {
  late MockImagePicker picker;
  late ImagePickerServiceImpl service;

  setUp(() {
    picker = MockImagePicker();
    service = ImagePickerServiceImpl(picker);
  });

  test('returns ImagePicked when a file is selected', () async {
    when(
      () => picker.pickImage(source: ImageSource.gallery),
    ).thenAnswer((_) async => _FakeXFile('/tmp/photo.jpg'));

    final result = await service.pick(ImagePickSource.gallery);

    expect(result, isA<ImagePicked>());
    expect((result as ImagePicked).path, '/tmp/photo.jpg');
  });

  test('returns ImagePickCancelled when the user cancels', () async {
    when(
      () => picker.pickImage(source: ImageSource.camera),
    ).thenAnswer((_) async => null);

    final result = await service.pick(ImagePickSource.camera);

    expect(result, const ImagePickCancelled());
  });

  test(
    'returns ImagePickPermissionDenied for camera permission errors',
    () async {
      when(
        () => picker.pickImage(source: ImageSource.camera),
      ).thenThrow(PlatformException(code: 'camera_access_denied'));

      final result = await service.pick(ImagePickSource.camera);

      expect(result, const ImagePickPermissionDenied());
    },
  );

  test('returns ImagePickFailed for other platform errors', () async {
    when(
      () => picker.pickImage(source: ImageSource.gallery),
    ).thenThrow(PlatformException(code: 'unknown', message: 'broken'));

    final result = await service.pick(ImagePickSource.gallery);

    expect(result, isA<ImagePickFailed>());
    expect((result as ImagePickFailed).message, 'broken');
  });
}
