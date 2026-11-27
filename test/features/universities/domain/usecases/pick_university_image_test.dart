import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:universities_app/core/error/failure.dart';
import 'package:universities_app/features/universities/domain/entities/image_origin.dart';
import 'package:universities_app/features/universities/domain/repositories/image_picker_repository.dart';
import 'package:universities_app/features/universities/domain/usecases/pick_university_image.dart';

class MockImagePickerRepository extends Mock implements ImagePickerRepository {}

void main() {
  late MockImagePickerRepository repository;
  late PickUniversityImage useCase;

  setUp(() {
    repository = MockImagePickerRepository();
    useCase = PickUniversityImage(repository);
  });

  test('delegates pick to the repository', () async {
    when(
      () => repository.pick(ImageOrigin.camera),
    ).thenAnswer((_) async => const Ok<String?, Failure>('/tmp/file.jpg'));

    final result = await useCase(ImageOrigin.camera);

    expect(result, const Ok<String?, Failure>('/tmp/file.jpg'));
    verify(() => repository.pick(ImageOrigin.camera)).called(1);
  });
}
