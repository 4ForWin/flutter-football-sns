import 'package:image_picker/image_picker.dart';

abstract interface class ImageRepository {
  Future<String> uploadImage(XFile xfile);
}
