class UserModel {
  String username;
  String email;
  String password;
  String uid;
  String? profileImageURL;
  List<dynamic>? followers;
  List<dynamic>? following;
  List<dynamic>? serachedPeople;
  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
    this.profileImageURL,
    required this.followers,
    required this.following,
    required this.serachedPeople,
  });
  factory UserModel.fromJson(json) {
    return UserModel(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        followers: json['followers'],
        following: json['following'],
        profileImageURL: json['profileImageURL'],
        uid: json['uid'],
        serachedPeople: json['searched people']);
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
    };
  }
}
