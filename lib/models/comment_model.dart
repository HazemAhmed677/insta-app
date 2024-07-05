import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String username;
  String? imageProfile;
  String comment;
  String commentID;
  String uid;
  List likes;
  final Timestamp dataTime;
  CommentModel(
      {required this.username,
      required this.comment,
      this.imageProfile,
      required this.likes,
      required this.dataTime,
      required this.commentID,
      required this.uid});

  factory CommentModel.fromJson(json) {
    return CommentModel(
      username: json['username'],
      imageProfile: json['imageProfile'],
      likes: json['likes'],
      comment: json['comment'],
      dataTime: json['date time'],
      commentID: json['commentID'],
      uid: json['uid'],
    );
  }
  Map<String, dynamic> convetToMap(CommentModel commentModel) {
    return {
      'username': commentModel.username,
      'imageProfile': commentModel.imageProfile,
      'likes': commentModel.likes,
      'comment': commentModel.comment,
      'date time': commentModel.dataTime,
      'commentID': commentModel.commentID,
      'uid': commentModel.uid,
    };
  }
}
