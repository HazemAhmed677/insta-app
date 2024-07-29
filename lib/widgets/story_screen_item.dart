import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/views/custom_story_view.dart';

class StoryScreenItem extends StatefulWidget {
  const StoryScreenItem({
    super.key,
    required this.stories,
    required this.snapshot,
    required this.index,
  });
  final List<dynamic> stories;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final int index;

  @override
  State<StoryScreenItem> createState() => _StoryScreenItemState();
}

class _StoryScreenItemState extends State<StoryScreenItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (widget.index != widget.snapshot.data!.size)
          ? const EdgeInsets.only(
              right: 18.0,
            )
          : EdgeInsets.zero,
      child: (widget.snapshot.hasData)
          ? Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(34),
                  onTap: () {
                    Map<String, dynamic> userMap =
                        widget.snapshot.data!.docs[widget.index].data();
                    UserModel userModel = UserModel.fromJson(userMap);
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
                      backgroundImage: (widget.snapshot.data!.docs[widget.index]
                                  ['profileImageURL'] !=
                              null)
                          ? CachedNetworkImageProvider(widget.snapshot.data!
                              .docs[widget.index]['profileImageURL'])
                          : const AssetImage(kNullImage),
                      radius: 40,
                    ),
                  ),
                ),
                Text(
                  widget.snapshot.data!.docs[widget.index]['username'],
                  style: const TextStyle(fontSize: 16),
                )
              ],
            )
          : const SizedBox(),
    );
  }
}
