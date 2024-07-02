import 'package:insta_app/models/post_model.dart';

class UserModel {
  String username;
  String email;
  String password;
  String? profileImageURL;
  List<PostModel>? posts;
  List<dynamic>? followers;
  List<dynamic>? following;
  UserModel({
    required this.username,
    required this.email,
    required this.password,
    this.profileImageURL,
    this.posts,
    this.followers,
    this.following,
  });
}
