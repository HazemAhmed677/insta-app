import 'package:firebase_storage/firebase_storage.dart';

class StorageColudService {
  uploadImage(String? image) {
    if (image != null) {
      FirebaseStorage.instance.ref('images').child(image);
    }
  }
}
