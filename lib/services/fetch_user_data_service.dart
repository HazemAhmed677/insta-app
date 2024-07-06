import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';

class FetchUserDataService {
  fetchUserData({required String id}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userJson =
          await FirebaseFirestore.instance.collection(kUsers).doc(id).get();
      UserModel user = UserModel.fromJson(userJson);
      return user;
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
