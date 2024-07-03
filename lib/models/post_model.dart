class PostModel {
  String userID;
  String imageURL;
  List<Map<String, dynamic>>? numberOfLikes;
  String? desciption;
  List<Map<String, dynamic>>? comments;
  PostModel(
      {required this.userID,
      required this.imageURL,
      required this.numberOfLikes,
      this.desciption});
}
