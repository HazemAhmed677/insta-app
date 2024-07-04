import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String userID;
  String imageURL;
  String postID;
  List<String> likes;
  Timestamp timestamp;
  String? desciption;
  PostModel({
    required this.userID,
    required this.imageURL,
    required this.likes,
    required this.postID,
    required this.timestamp,
    this.desciption = '',
  });
  factory PostModel.fromJson(json) {
    return PostModel(
      userID: json['userID'],
      imageURL: json['imageURL'],
      likes:
          (json['likes'] as List).map((element) => element as String).toList(),
      desciption: json['desciption'],
      postID: json['postID'],
      timestamp: json['date time'],
    );
  }
  Map<String, dynamic> convertToMap(PostModel post) {
    return {
      'userID': post.userID,
      'imageURL': post.imageURL,
      'likes': post.likes,
      'desciption': post.desciption,
      'postID': post.postID,
      'date time': post.timestamp,
    };
  }
}
