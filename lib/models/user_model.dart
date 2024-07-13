import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String password;
  String uid;
  String? profileImageURL;
  List<dynamic>? followers;
  List<dynamic>? following;
  List<dynamic>? serachedPeople;
  List<dynamic>? stories;
  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.uid,
      this.profileImageURL,
      required this.followers,
      required this.following,
      required this.serachedPeople,
      required this.stories});
  factory UserModel.fromJson(json) {
    return UserModel(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        followers: json['followers'],
        following: json['following'],
        profileImageURL: json['profileImageURL'],
        uid: json['uid'],
        serachedPeople: json['searched people'],
        stories: json['stories']);
  }
  Map<String, dynamic> convertToMap(UserModel user) {
    return {
      'username': user.username,
      'email': user.email,
      'password': user.password,
      'profileImageURL': user.profileImageURL,
      'followers': user.followers,
      'following': user.following,
      'uid': user.uid,
      'searched people': user.serachedPeople,
      'stories': user.stories,
    };
  }
}

class Story {
  String uid;
  String storyID;
  String content;
  String type;
  String? caption;
  Timestamp date;

  Story(
      {required this.content,
      required this.storyID,
      required this.type,
      required this.date,
      required this.uid,
      required this.caption});
  factory Story.fromJson(json) {
    return Story(
        content: json['content'],
        storyID: json['storyID'],
        type: json['type'],
        date: json['date'],
        uid: json['uid'],
        caption: json['caption']);
  }
  Map<String, dynamic> convertToMap(Story story) {
    return {
      'content': story.content,
      'storyID': story.storyID,
      'type': story.type,
      'date': story.date,
      'uid': story.uid,
      'caption': story.caption,
    };
  }
}
