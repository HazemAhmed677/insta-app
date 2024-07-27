import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';

class DeleteStoryAfter24H {
  void deleteStoryAfter24hours(List stories, UserModel userModel) {
    if (stories.isNotEmpty) {
      try {
        for (var ele in stories) {
          Duration difference = DateTime.now().difference(
            ele['date'].toDate(),
          );
          if (difference.inHours > 24) {
            FirebaseFirestore.instance
                .collection(kUsers)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              'stories': FieldValue.arrayRemove([ele])
            });
            userModel.stories!.remove(ele);
          }
        }
      } catch (e) {
        //
      }
    }
  }
}
