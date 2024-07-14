import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

class CustomStoryView extends StatefulWidget {
  const CustomStoryView({super.key, required this.userModel});
  final UserModel userModel;
  @override
  State<CustomStoryView> createState() => _CustomStoryViewState();
}

class _CustomStoryViewState extends State<CustomStoryView> {
  StoryController storyController = StoryController();

  deleteStoryAfter24hours(Map story) async {
    Duration difference = DateTime.now().difference(story['date'].toDate);
    if (difference.inMinutes > 1) {
      await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'stories': FieldValue.arrayRemove([story])
      });
    }
  }

  @override
  void initState() {
    for (var ele in widget.userModel.stories!) {
      deleteStoryAfter24hours(ele);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List stories = widget.userModel.stories!;
    return SafeArea(
      child: Scaffold(
        body: StoryView(
          onComplete: () {
            Navigator.pop(context);
          },
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
          controller: storyController,
          storyItems: stories
              .map(
                (ele) => (ele['type'] == 'image')
                    ? StoryItem.pageImage(
                        url: ele['content'],
                        controller: storyController,
                        caption: (ele['caption'] != null)
                            ? Text(
                                ele['caption'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              )
                            : const Text(''))
                    : StoryItem.pageVideo(
                        ele['content'],
                        duration: const Duration(seconds: 30),
                        controller: storyController,
                        caption: (ele['caption'] != null)
                            ? Text(
                                ele['caption'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              )
                            : const Text(''),
                      ),
              )
              .toList(),
        ),
      ),
    );
  }
}
