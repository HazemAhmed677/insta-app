import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/comment_model.dart';

class AddRemoveLikeCommentService {
  fetchAllLikesComment(String postID, CommentModel commentModel) async {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid;
    var commentDoc = await FirebaseFirestore.instance
        .collection(kPosts)
        .doc(postID)
        .collection(kComments)
        .doc(commentModel.commentID)
        .get();
    List likes = commentDoc['likes'];
    if (likes.contains(currentUserID)) {
      FirebaseFirestore.instance
          .collection(kPosts)
          .doc(postID)
          .collection(kComments)
          .doc(commentModel.commentID)
          .update({
        'likes': FieldValue.arrayRemove([currentUserID]),
      });
      commentModel.likes.remove(currentUserID);
    } else {
      FirebaseFirestore.instance
          .collection(kPosts)
          .doc(postID)
          .collection(kComments)
          .doc(commentModel.commentID)
          .update({
        'likes': FieldValue.arrayUnion([currentUserID]),
      });
      commentModel.likes.add(currentUserID);
    }
  }
}
