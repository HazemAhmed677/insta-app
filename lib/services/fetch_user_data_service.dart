import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';

class FetchUserDataService {
  Future<UserModel> fetchUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userJson = await FirebaseFirestore
        .instance
        .collection(kCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    UserModel user = UserModel.fromJson(userJson);
    return user;
  }
}
