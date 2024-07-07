import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';

class FollowerAndFolloweingService {
  followAndUnfollowPerson(
      {required UserModel currentUser, required UserModel user}) async {
    String currentUID = currentUser.uid;
    var doc =
        await FirebaseFirestore.instance.collection(kUsers).doc(user.uid).get();
    List followers = doc['followers'];
    List following = doc['following'];
    user.followers = followers;
    currentUser.following = following;
    if (followers.contains(currentUID)) {
      await FirebaseFirestore.instance.collection(kUsers).doc(user.uid).update({
        'followers': FieldValue.arrayRemove([currentUID])
      });
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(currentUID)
          .update({
        'following': FieldValue.arrayRemove([user.uid])
      });
      user.followers!.remove(currentUID);
      currentUser.following!.remove(user.uid);
    } else {
      await FirebaseFirestore.instance.collection(kUsers).doc(user.uid).update({
        'followers': FieldValue.arrayUnion([currentUID])
      });
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(currentUID)
          .update({
        'following': FieldValue.arrayUnion([user.uid])
      });
      user.followers!.add(currentUID);
      currentUser.following!.add(user.uid);
    }
  }
}
