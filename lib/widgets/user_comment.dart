import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/comment_model.dart';
import 'package:insta_app/services/add_remove_like_comment_service.dart';

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
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: (commentModel.imageProfile != null)
              ? NetworkImage(commentModel.imageProfile!)
              : null,
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
                await AddRemoveLikeCommentService()
                    .fetchAllLikesComment(widget.postID, commentModel);
                setState(() {});
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
  }
}
