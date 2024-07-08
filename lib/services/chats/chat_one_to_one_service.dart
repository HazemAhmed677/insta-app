import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';

class ChatOneToOneService {
  Future<void> pushMessegeToFireStore(
      {required String messege,
      required String currentUserID,
      required UserModel reciever}) async {
    String roomID =
        kChatRoomID(currentUserID: currentUserID, chatedOneID: reciever.uid);
    try {
      await FirebaseFirestore.instance
          .collection(kChats)
          .doc(roomID)
          .collection(kMesseges)
          .add({
        'messege': messege,
        'sent at': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot> fetchAllMesseges(
      {required String messege,
      required String currentUserID,
      required UserModel reciever}) async* {
    String roomID =
        kChatRoomID(currentUserID: currentUserID, chatedOneID: reciever.uid);
    try {
      QuerySnapshot<Map<String, dynamic>> docs = await FirebaseFirestore
          .instance
          .collection(kChats)
          .doc(roomID)
          .collection(kMesseges)
          .get();

      yield docs;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
