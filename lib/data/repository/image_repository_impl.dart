import 'package:image_picker/image_picker.dart';
import 'package:mercenaryhub/data/data_source/image_data_source.dart';
import 'package:mercenaryhub/domain/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDataSource _imageDataSource;

  ImageRepositoryImpl(this._imageDataSource);

  @override
  Future<String> uploadImage(XFile xfile) async {
    String imageUrl = await _imageDataSource.uploadImage(xfile);
    return imageUrl;
  }
}
