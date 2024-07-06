import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';

class FetchAndPushSearchedPeopleService {
  Future fetchAllSearched({required UserModel currentUser}) async {
    String currentUid = currentUser.uid;
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(currentUid)
          .get();
      currentUser.serachedPeople = userDoc['searched people'];
      return currentUser.serachedPeople;
    } catch (e) {
      print(e.toString());
    }
  }

  Future pushSerached(
      {required UserModel currentUser, required UserModel searchedOne}) async {
    try {
      String currentUid = currentUser.uid;
      if (!currentUser.serachedPeople!
          .map((ele) => ele)
          .contains(searchedOne.username)) {
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(currentUid)
            .update({
          'searched people': FieldValue.arrayUnion([
            {
              'username': searchedOne.username,
              'profile image': searchedOne.profileImageURL,
            },
          ])
        });
        currentUser.serachedPeople!.add(searchedOne);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future removeSearchHistory({required UserModel currentUser}) async {
    String currentUid = currentUser.uid;
    try {
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(currentUid)
          .update({'searched people': FieldValue.delete()});
      currentUser.serachedPeople!.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
