import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:story_view/controller/story_controller.dart';
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
  Widget build(BuildContext context) {
    List stories = widget.userModel.stories!;
    return SafeArea(
      child: StoryView(
        controller: storyController,
        storyItems: stories
            .map((ele) => (ele['type'] == 'image')
                ? StoryItem(CachedNetworkImage(imageUrl: ele['content']),
                    duration: const Duration(seconds: 5))
                : StoryItem(CachedNetworkImage(imageUrl: ele['content']),
                    duration: const Duration(seconds: 5)))
            .toList(),
      ),
    );
  }
}
