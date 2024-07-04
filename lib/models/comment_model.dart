class CommentModel {
  String username;
  String? imageProfile;
  String comment;
  List? likes;
  final DateTime dataTime;
  CommentModel({
    required this.username,
    required this.comment,
    this.imageProfile,
    this.likes,
    required this.dataTime,
  });

  factory CommentModel.fromJson(json) {
    return CommentModel(
      username: json['username'],
      imageProfile: json['imageProfile'],
      likes: json['likes'],
      comment: json['comment'],
      dataTime: json['date time'],
    );
  }
  Map<String, dynamic> convetToMap(CommentModel commentModel) {
    return {
      'username': commentModel.username,
      'imageProfile': commentModel.imageProfile,
      'likes': commentModel.likes,
      'comment': commentModel.comment,
      'data time': commentModel.dataTime,
    };
  }
}
