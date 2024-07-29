import 'package:flutter/material.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/delete_story_after_24_h.dart';
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

  @override
  void initState() {
    super.initState();
    try {
      for (var ele in widget.userModel.stories!) {
        DeleteStoryAfter24H().deleteStoryAfter24hours(ele, widget.userModel);
      }
    } catch (e) {
      //
    }
  }

  @override
  void dispose() {
    super.dispose();
    storyController.dispose();
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
