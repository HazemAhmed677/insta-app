class CommentModel {
  String username;
  String? imageProfile;
  String comment;
  List? likes;
  CommentModel({
    required this.username,
    required this.comment,
    this.imageProfile,
    this.likes,
  });

  factory CommentModel.fromJson(json) {
    return CommentModel(
      username: json['username'],
      imageProfile: json['imageProfile'],
      likes: json['likes'],
      comment: json['comment'],
    );
  }
  Map<String, dynamic> convetToMap(CommentModel commentModel) {
    return {
      'userneme': commentModel.username,
      'imageProfile': commentModel.imageProfile,
      'likes': commentModel.likes,
      'comment': commentModel.comment,
    };
  }
}
