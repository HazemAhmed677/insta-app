import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<DocumentReference<Map<String, dynamic>>> addUserToFireStore(
      Map<String, dynamic> user) async {
    return await FirebaseFirestore.instance.collection('users').add(user);
  }
}
