import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/comment_model.dart';

class UserComment extends StatefulWidget {
  const UserComment(
      {super.key, required this.commentQueryDoc, required this.postID});
  final QueryDocumentSnapshot<Map<String, dynamic>> commentQueryDoc;
  final String postID;
  @override
  State<UserComment> createState() => _UserCommentState();
}

class _UserCommentState extends State<UserComment> {
  @override
  Widget build(BuildContext context) {
    CommentModel commentModel = CommentModel.fromJson(widget.commentQueryDoc);
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kPosts)
            .doc(widget.postID)
            .collection(kComments)
            .doc(commentModel.commentID)
            .snapshots(),
        builder: (context, snapshot) {
          return Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: (commentModel.imageProfile != null)
                    ? CachedNetworkImageProvider(commentModel.imageProfile!)
                    : const AssetImage(kNullImage),
              ),
              SizedBox(
                width: width * 0.025,
              ),
              SizedBox(
                width: width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commentModel.username,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        commentModel.comment,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 8),
                    constraints: const BoxConstraints(),
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () async {
                      Map<String, dynamic> commmentMap = snapshot.data!.data()!;
                      List likes = commmentMap['likes'];
                      if (likes.contains(currentUserID)) {
                        FirebaseFirestore.instance
                            .collection(kPosts)
                            .doc(widget.postID)
                            .collection(kComments)
                            .doc(commentModel.commentID)
                            .update({
                          'likes': FieldValue.arrayRemove([currentUserID]),
                        });
                        commentModel.likes.remove(currentUserID);
                      } else {
                        FirebaseFirestore.instance
                            .collection(kPosts)
                            .doc(widget.postID)
                            .collection(kComments)
                            .doc(commentModel.commentID)
                            .update({
                          'likes': FieldValue.arrayUnion([currentUserID]),
                        });
                        commentModel.likes.add(currentUserID);
                      }
                    },
                    icon: (!commentModel.likes
                            .contains(FirebaseAuth.instance.currentUser!.uid))
                        ? const Icon(
                            Icons.favorite_border,
                          )
                        : const Icon(Icons.favorite, color: kPink),
                  ),
                  Text(
                    commentModel.likes.length.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              )
            ],
          );
        });
  }
}
