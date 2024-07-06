import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';

class FetchAndPushSearchedPeopleService {
  Future<List<dynamic>?> fetchAllSearched(
      {required UserModel currentUser}) async {
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
      return null;
    }
  }

  Future pushSerached(
      {required UserModel currentUser, required UserModel searchedOne}) async {
    try {
      String currentUid = currentUser.uid;
      if (!(currentUser.serachedPeople!.contains(searchedOne.serachedPeople))) {
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(currentUid)
            .update({
          'searched people': FieldValue.arrayUnion([
            {
              'username': searchedOne.username,
              'profile image': searchedOne.profileImageURL,
              'uid': searchedOne.uid,
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
          .update({'searched people': []});
      currentUser.serachedPeople!.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
