import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  addUserToFireStore(Map<String, dynamic> user) async {
    await FirebaseFirestore.instance.collection('users').add(user);
  }
}
