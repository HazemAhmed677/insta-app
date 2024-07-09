import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/post_tile.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';

class CustomPostWidget extends StatefulWidget {
  const CustomPostWidget(
      {super.key, required this.postModel, required this.currentUser});
  final PostModel postModel;
  final UserModel currentUser;
  @override
  State<CustomPostWidget> createState() => _CustomPostWidgetState();
}

class _CustomPostWidgetState extends State<CustomPostWidget> {
  bool isLiked = false;
  late List<String> likes;
  var future;
  @override
  void initState() {
    future = FirebaseFirestore.instance
        .collection(kUsers)
        .doc(widget.postModel.userID)
        .get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    String imageURL = widget.postModel.imageURL;
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 0.72 * hight,
            child: const Center(
                child: CircularProgressIndicator(
              color: kPink,
            )),
          );
        } else if (snapshot.hasData) {
          UserModel userModel = UserModel.fromJson(snapshot.data);
          return PostTile(
            userModel: userModel,
            imageURL: imageURL,
            postModel: widget.postModel,
            currentUser: widget.currentUser,
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return const Text('');
          // return const Center(
          //     child: CircularProgressIndicator(
          //   color: kPink,
          // ));
        }
      },
    );
  }
}
