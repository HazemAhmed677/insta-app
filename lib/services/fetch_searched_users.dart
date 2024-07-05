import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_app/constants.dart';

class FetchSearchedUsers {
  Future<QuerySnapshot<Map<String, dynamic>>> fetchSearchedUsers(
      String input) async {
    return await FirebaseFirestore.instance
        .collection(kUsers)
        .where('username', isEqualTo: input)
        .get();
  }
}
