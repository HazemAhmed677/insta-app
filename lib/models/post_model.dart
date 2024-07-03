class PostModel {
  String userID;
  String imageURL;
  List<Map<String, dynamic>>? likes;
  String? desciption;
  List<Map<String, dynamic>>? comments;
  PostModel(
      {required this.userID,
      required this.imageURL,
      required this.likes,
      this.desciption,
      this.comments});
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
      'numberOfLikes': post.likes,
      'desciption': post.desciption,
      'comments': post.comments,
    };
  }
}
