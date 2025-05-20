import 'package:image_picker/image_picker.dart';
import 'package:mercenaryhub/domain/repository/image_repository.dart';

class UploadImageUsecase {
  final ImageRepository _imageRepository;

  UploadImageUsecase(this._imageRepository);

  Future<String> execute(XFile xfile) async {
    return await _imageRepository.uploadImage(xfile);
  }
}
