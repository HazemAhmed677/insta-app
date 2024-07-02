class UserModel {
  String username;
  String email;
  String password;
  String? profileImageURL;
  List<dynamic>? followers;
  List<dynamic>? following;
  UserModel({
    required this.username,
    required this.email,
    required this.password,
    this.profileImageURL,
    required this.followers,
    required this.following,
  });
  factory UserModel.fromJson(json) {
    return UserModel(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        followers: json['followers'],
        following: json['following']);
  }
  Map<String, dynamic> convertToMap(UserModel user) {
    return {
      'username': user.username,
      'email': user.email,
      'password': user.password,
      'profileImageURL': user.profileImageURL,
      'followers': user.followers,
      'following': user.following,
    };
  }
}
