class PostModel {
  String userID;
  String imageURL;
  String postID;
  List<String> likes;
  String? desciption;
  PostModel({
    required this.userID,
    required this.imageURL,
    required this.likes,
    required this.postID,
    this.desciption = '',
  });
  factory PostModel.fromJson(json) {
    return PostModel(
        userID: json['userID'],
        imageURL: json['imageURL'],
        likes: (json['likes'] as List)
            .map((element) => element as String)
            .toList(),
        desciption: json['desciption'],
        postID: json['postID']);
  }
  Map<String, dynamic> convertToMap(PostModel post) {
    return {
      'userID': post.userID,
      'imageURL': post.imageURL,
      'likes': post.likes,
      'desciption': post.desciption,
      'postID': post.postID,
    };
  }
}
