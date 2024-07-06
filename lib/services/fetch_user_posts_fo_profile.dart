import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_app/constants.dart';

class FetchUserPostsForProfile {
  Future<QuerySnapshot<Map<String, dynamic>>> fetchUserPostsFoProfile(
      {required String uid}) async {
    try {
      var userPosts = await FirebaseFirestore.instance
          .collection(kPosts)
          .where('userID', isEqualTo: uid)
          .get();
      return userPosts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
