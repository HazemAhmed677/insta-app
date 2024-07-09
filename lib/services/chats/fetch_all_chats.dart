import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_app/constants.dart';

class FetchAllChats {
  fetchAllChats({
    required String currentUserID,
  }) async {
    var rooms = FirebaseFirestore.instance
        .collection(kChats)
        .where('participants', arrayContains: currentUserID)
        .snapshots();
  }
}
