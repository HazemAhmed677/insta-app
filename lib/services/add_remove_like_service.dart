import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/post_model.dart';

class AddRemoveLikeService {
  Future<bool> addOrRemoeLike({required PostModel postModel}) async {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    var postFromFireStore = await FirebaseFirestore.instance
        .collection(kPosts)
        .doc(postModel.postID)
        .get();
    List<String> likes = (postFromFireStore['likes'] as List)
        .map((element) => element as String)
        .toList();
    if (likes.contains(currentUserID)) {
      await FirebaseFirestore.instance
          .collection(kPosts)
          .doc(postModel.postID)
          .update({
        'likes': FieldValue.arrayRemove([currentUserID]),
      });
      postModel.likes.remove(currentUserID);
      return false;
    } else {
      await FirebaseFirestore.instance
          .collection(kPosts)
          .doc(postModel.postID)
          .update({
        'likes': FieldValue.arrayUnion([currentUserID])
      });
      postModel.likes.add(currentUserID);
      return true;
    }
  }
}
