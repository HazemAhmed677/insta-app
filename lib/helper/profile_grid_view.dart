import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/post_widget.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';

class ProfileGridView extends StatelessWidget {
  const ProfileGridView({
    super.key,
    required this.posts,
    required this.currentUser,
  });
  final QuerySnapshot<Map<String, dynamic>>? posts;
  final UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    // ************************************** //
    // add bloc bilder of fetching  posts here
    return SliverGrid.builder(
      itemCount: posts?.size ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.95,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
      itemBuilder: (context, index) {
        return (currentUser != null)
            ? InkWell(
                splashColor: kWhite,
                onTap: () {
                  PostModel postModel = PostModel.fromJson(posts!.docs[index]);
                  Get.to(
                      Scaffold(
                        backgroundColor: kBlack,
                        body: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.12),
                          child: CustomPostWidget(
                              postModel: postModel, currentUser: currentUser!),
                        ),
                      ),
                      transition: Transition.zoom);
                },
                child: ClipRRect(
                    child: CachedNetworkImage(
                        imageUrl: posts!.docs[index]['imageURL'],
                        fit: BoxFit.cover,
                        placeholder: (context, e) {
                          return Image.asset(kLoadingPhoto);
                        })),
              )
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(kUsers)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  return InkWell(
                    onTap: () {
                      PostModel postModel =
                          PostModel.fromJson(posts!.docs[index]);
                      (snapshot.connectionState == ConnectionState.waiting)
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kPink,
                              ),
                            )
                          : (snapshot.hasData)
                              ? Get.to(
                                  SafeArea(
                                    child: Scaffold(
                                      backgroundColor: kBlack,
                                      body: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 22.0,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1),
                                        child: CustomPostWidget(
                                            postModel: postModel,
                                            currentUser: UserModel.fromJson(
                                                snapshot.data!.data())),
                                      ),
                                    ),
                                  ),
                                  transition: Transition.zoom)
                              : const Text('');
                    },
                    child: ClipRRect(
                      child: CachedNetworkImage(
                          imageUrl: posts!.docs[index]['imageURL'],
                          fit: BoxFit.cover,
                          placeholder: (context, e) {
                            return Image.asset(kLoadingPhoto);
                          }),
                    ),
                  );
                });
      },
    );
  }
}
