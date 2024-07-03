class CommentModel {
  String username;
  String? imageProfile;
  String uid;
  int? numOfLikes;
  CommentModel({
    required this.username,
    required this.uid,
    this.imageProfile,
    this.numOfLikes,
  });

  factory CommentModel.fromJson(json) {
    return CommentModel(
      username: json['username'],
      uid: json['uid'],
      imageProfile: json['imageProfile'],
      numOfLikes: json['numOfLikes'],
    );
  }
  Map<String, dynamic> convetToMap(CommentModel commentModel) {
    return {
      'userneme': commentModel.username,
      'uid': commentModel.uid,
      'imageProfile': commentModel.imageProfile,
      'numOfLikes': commentModel.numOfLikes,
    };
  }
}
