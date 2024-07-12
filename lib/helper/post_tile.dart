import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:insta_app/constants.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/views/add_comment_view.dart';
import 'package:insta_app/views/chat_view.dart';

class PostTile extends StatefulWidget {
  const PostTile(
      {super.key,
      required this.userModel,
      required this.imageURL,
      required this.postModel,
      required this.currentUser});
  final UserModel userModel;
  final UserModel currentUser;
  final String imageURL;
  final PostModel postModel;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kPosts)
            .doc(widget.postModel.postID)
            .snapshots(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: (widget.userModel.profileImageURL != null)
                        ? CachedNetworkImageProvider(
                            widget.userModel.profileImageURL!)
                        : const AssetImage(kNullImage),
                  ),
                  SizedBox(
                    width: 0.03 * width,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.userModel.username,
                        style: const TextStyle(
                          color: kWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(
                          Icons.verified,
                          size: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 0.02 * hight,
              ),
              SizedBox(
                height: 0.51 * hight,
                width: width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageURL,
                    fit: BoxFit.fitHeight,
                    placeholder: (context, imageURL) => const Center(
                        child: CircularProgressIndicator(
                      color: kPink,
                    )), // Show loading indicator
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error), // Show error icon
                  ),
                ),
              ),
              SizedBox(
                height: hight * 0.025,
              ),
              Row(
                children: [
                  IconButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(10, 20),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () async {
                      Map<String, dynamic> likesList = snapshot.data!.data()!;
                      List<String> likes = (likesList['likes'] as List)
                          .map((element) => element as String)
                          .toList();
                      if (likes
                          .contains(FirebaseAuth.instance.currentUser!.uid)) {
                        await FirebaseFirestore.instance
                            .collection(kPosts)
                            .doc(widget.postModel.postID)
                            .update({
                          'likes': FieldValue.arrayRemove([currentUserID]),
                        });
                        widget.postModel.likes.remove(currentUserID);
                      } else {
                        await FirebaseFirestore.instance
                            .collection(kPosts)
                            .doc(widget.postModel.postID)
                            .update({
                          'likes': FieldValue.arrayUnion([currentUserID])
                        });
                        widget.postModel.likes.add(currentUserID);
                      }
                    },
                    icon: (widget.postModel.likes
                            .contains(FirebaseAuth.instance.currentUser!.uid))
                        ? const Icon(
                            Icons.favorite,
                            color: kPink,
                            size: 28,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            size: 28,
                          ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  (FirebaseAuth.instance.currentUser!.uid !=
                          widget.userModel.uid)
                      ? IconButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(right: 2, left: 1),
                            minimumSize: const Size(20, 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Get.to(
                              ChatView(
                                currentUserID:
                                    FirebaseAuth.instance.currentUser!.uid,
                                recieverUser: widget.userModel,
                              ),
                              transition: Transition.fadeIn,
                            );
                          },
                          icon: const Icon(
                            FontAwesomeIcons.facebookMessenger,
                            color: Colors.blue,
                          ))
                      : IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Get.to(
                              AddCommentView(
                                userModel: widget.currentUser,
                              ),
                              arguments: widget.postModel,
                              duration: const Duration(milliseconds: 240),
                              transition: Transition.rightToLeft,
                            );
                          },
                          icon: const Icon(
                            FontAwesomeIcons.commentDots,
                          ))
                ],
              ),
              SizedBox(
                height: 0.01 * hight,
              ),
              Text(
                (widget.postModel.likes.length != 1)
                    ? "${widget.postModel.likes.length.toString()} likes"
                    : "${widget.postModel.likes.length.toString()} like",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 0.009 * hight,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userModel.username,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 2.0, top: 5),
                    child: Icon(
                      Icons.verified,
                      size: 16,
                      color: Colors.blue,
                    ),
                  ),
                  (widget.postModel.desciption != null)
                      ? Text(
                          " ${widget.postModel.desciption!}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              SizedBox(
                height: 0.012 * hight,
              ), ////
              SizedBox(
                height: hight * 0.038,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                      Colors.white,
                    ),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(14),
                            bottomLeft: Radius.circular(16)),
                        side: BorderSide(
                          color: Colors.grey.shade500,
                        ), // White outline border
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.to(
                      AddCommentView(
                        userModel: widget.currentUser,
                      ),
                      arguments: widget.postModel,
                      duration: const Duration(milliseconds: 240),
                      transition: Transition.rightToLeft,
                    );
                    // Navigator.pushNamed(context, AddCommentView.addCommentView,
                    //     arguments: widget.postModel);
                  },
                  child: const Text(
                    'Add Comment...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hight * 0.035,
              ),
            ],
          );
        });
  }
}
