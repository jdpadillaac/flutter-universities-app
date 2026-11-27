enum ImagePickSource { camera, gallery }

sealed class ImagePickResult {
  const ImagePickResult();
}

final class ImagePicked extends ImagePickResult {
  const ImagePicked(this.path);

  final String path;
}

final class ImagePickCancelled extends ImagePickResult {
  const ImagePickCancelled();
}

final class ImagePickPermissionDenied extends ImagePickResult {
  const ImagePickPermissionDenied();
}

final class ImagePickFailed extends ImagePickResult {
  const ImagePickFailed(this.message);

  final String message;
}

abstract interface class ImagePickerService {
  Future<ImagePickResult> pick(ImagePickSource source);
}
