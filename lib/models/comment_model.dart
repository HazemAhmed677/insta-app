class CommentModel {
  String username;
  String? imageProfile;
  String comment;
  List? usersliked;
  CommentModel({
    required this.username,
    required this.comment,
    this.imageProfile,
    this.usersliked,
  });

  factory CommentModel.fromJson(json) {
    return CommentModel(
      username: json['username'],
      imageProfile: json['imageProfile'],
      usersliked: json['likes'],
      comment: json['comment'],
    );
  }
  Map<String, dynamic> convetToMap(CommentModel commentModel) {
    return {
      'userneme': commentModel.username,
      'imageProfile': commentModel.imageProfile,
      'likes': commentModel.usersliked,
      'comment': commentModel.comment,
    };
  }
}
