class PostModel {
  String username;
  String image;
  int numberOfLikes;
  String? desciption;
  PostModel(
      {required this.username,
      required this.image,
      required this.numberOfLikes,
      this.desciption});
}
