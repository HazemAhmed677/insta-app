import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/views/custom_story_view.dart';

class StoriesBar extends StatelessWidget {
  const StoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsers)
            .where('followers',
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .where('stories', isNotEqualTo: []).snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.size ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: (index != 7)
                    ? const EdgeInsets.only(
                        right: 18.0,
                      )
                    : EdgeInsets.zero,
                child: (snapshot.hasData)
                    ? Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(34),
                            onTap: () {
                              Map<String, dynamic> userMap =
                                  snapshot.data!.docs[index].data();
                              UserModel userModel = UserModel.fromJson(userMap);
                              Get.to(
                                  CustomStoryView(
                                    userModel: userModel,
                                  ),
                                  transition: Transition.zoom);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kPink,
                                  width: 4,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    snapshot.data!.docs[index]
                                        ['profileImageURL']),
                                radius: 40,
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data!.docs[index]['username'],
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    : (snapshot.connectionState == ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: kPink,
                            ),
                          )
                        : const SizedBox(),
              );
            },
          );
        });
  }
}
