import 'package:firebase_storage/firebase_storage.dart';

class StorageColudService {
  Reference uploadImage(String image) {
    return FirebaseStorage.instance.ref('images').child(image);
  }
}
