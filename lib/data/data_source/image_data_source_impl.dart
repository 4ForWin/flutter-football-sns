import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercenaryhub/data/data_source/image_data_source.dart';

class ImageDataSourceImpl implements ImageDataSource {
  final FirebaseStorage _firestoageInstance; // FirebaseStorage.instance

  ImageDataSourceImpl(this._firestoageInstance);

  @override
  Future<String> uploadImage(XFile xfile) async {
    try {
      final storageRef = _firestoageInstance.ref();

      Reference fileRef = storageRef.child(
        '${DateTime.now().microsecondsSinceEpoch}_${xfile.name}',
      );

      await fileRef.putFile(File(xfile.path));
      return await fileRef.getDownloadURL();
    } catch (e, s) {
      print('❌uploadImage e: $e');
      print('❌uploadImage s: $s');
      return '';
    }
  }
}
