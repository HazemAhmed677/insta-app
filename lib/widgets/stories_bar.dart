import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/delete_story_after_24_h.dart';
import 'package:insta_app/views/add_story_view.dart';
import 'package:insta_app/views/custom_story_view.dart';

class StoriesBar extends StatelessWidget {
  const StoriesBar({super.key, required this.currentUser});
  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(34),
                onTap: () {
                  Get.to(AddStoryView(userModel: currentUser),
                      transition: Transition.downToUp);
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kWhite,
                          width: 4,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: (currentUser.profileImageURL != null)
                            ? CachedNetworkImageProvider(
                                currentUser.profileImageURL!)
                            : const AssetImage(kNullImage),
                        radius: 40,
                      ),
                    ),
                    const Positioned(
                      top: 66,
                      left: 34,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: kWhite,
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: kPink,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                currentUser.username,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(kUsers)
                .where('followers',
                    arrayContains: FirebaseAuth.instance.currentUser!.uid)
                .where('stories', isNotEqualTo: []).snapshots(),
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.size ?? 0,
                  itemBuilder: (context, index) {
                    Map user = snapshot.data!.docs[index].data();
                    List stories = user['stories'];
                    DeleteStoryAfter24H().deleteStoryAfter24hours(stories,
                        UserModel.fromJson(snapshot.data!.docs[index].data()));
                    return Padding(
                      padding: (index != snapshot.data!.size)
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
                                    UserModel userModel =
                                        UserModel.fromJson(userMap);
                                    Get.to(
                                        CustomStoryView(
                                          userModel: userModel,
                                        ),
                                        transition: Transition.downToUp);
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
                                      backgroundImage:
                                          (snapshot.data!.docs[index]
                                                      ['profileImageURL'] !=
                                                  null)
                                              ? CachedNetworkImageProvider(
                                                  snapshot.data!.docs[index]
                                                      ['profileImageURL'])
                                              : const AssetImage(kNullImage),
                                      radius: 40,
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['username'],
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            )
                          : const SizedBox(),
                    );
                  },
                ),
              );
            }),
      ],
    );
  }
}
