class ImageUploadCheck {
  static final ImageUploadCheck _session = ImageUploadCheck._internal();

  bool? isImageUploaded;

  factory ImageUploadCheck() {
    return _session;
  }

  ImageUploadCheck._internal() {}
}
