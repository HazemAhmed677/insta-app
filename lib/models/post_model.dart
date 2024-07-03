class PostModel {
  String userID;
  String imageURL;
  List<dynamic> likes;
  String? desciption;
  List<dynamic> comments;
  PostModel(
      {required this.userID,
      required this.imageURL,
      required this.likes,
      this.desciption = '',
      required this.comments});
  factory PostModel.fromJson(json) {
    return PostModel(
      userID: json['userID'],
      imageURL: json['imageURL'],
      likes: json['likes'],
      desciption: json['desciption'],
      comments: json['comments'],
    );
  }
  Map<String, dynamic> convertToMap(PostModel post) {
    return {
      'userID': post.userID,
      'imageURL': post.imageURL,
      'likes': post.likes,
      'desciption': post.desciption,
      'comments': post.comments,
    };
  }
}
