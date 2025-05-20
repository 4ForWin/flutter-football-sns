import 'package:image_picker/image_picker.dart';

abstract interface class ImageDataSource {
  Future<String> uploadImage(XFile xfile);
}
