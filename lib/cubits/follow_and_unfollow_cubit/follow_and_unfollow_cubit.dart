import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/follow_and_unfollow_cubit/follow_and_unfollow_states.dart';
import 'package:insta_app/models/user_model.dart';

class FollowAndUnfollowCubit extends Cubit<FollowAndUnfollowStates> {
  FollowAndUnfollowCubit() : super(InitalFollowAndUnfollowState());

  late List followerrs;

  Future<void> followAndUnfollowLogic(
      {required UserModel currentUser, required UserModel searchedOne}) async {
    String currentUID = currentUser.uid;

    try {
      var doc = await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(searchedOne.uid)
          .get();
      List followers = doc['followers'];
      List following = doc['following'];
      searchedOne.followers = followers;
      currentUser.following = following;
      if (followers.contains(currentUID)) {
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(searchedOne.uid)
            .update({
          'followers': FieldValue.arrayRemove([currentUID])
        });
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(currentUID)
            .update({
          'following': FieldValue.arrayRemove([searchedOne.uid])
        });
        searchedOne.followers!.remove(currentUID);
        followerrs = doc['followers'];
        currentUser.following!.remove(searchedOne.uid);
      } else {
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(searchedOne.uid)
            .update({
          'followers': FieldValue.arrayUnion([currentUID])
        });
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(currentUID)
            .update({
          'following': FieldValue.arrayUnion([searchedOne.uid])
        });
        searchedOne.followers!.add(currentUID);
        followerrs = doc['followers'];
        currentUser.following!.add(searchedOne.uid);
      }
      emit(SuccessFollowAndUnfollowState());
    } catch (e) {
      emit(FailuireFollowAndUnfollowState());
    }
  }

  int setFollowers(UserModel searchedOne) {
    return followerrs.length;
  }

  int incrementFollowers(UserModel searchedOne) {
    return followerrs.length + 1;
  }

  int decrementFollowers(UserModel searchedOne) {
    return followerrs.length - 1;
  }
}
