import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:video_player/video_player.dart';

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
        onComplete: () {
          Navigator.pop(context);
        },
        controller: storyController,
        storyItems: stories
            .map((ele) => (ele['type'] == 'image')
                ? StoryItem(
                    Scaffold(
                      backgroundColor: kBlack,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CachedNetworkImage(
                            imageUrl: ele['content'],
                            placeholder: (context, url) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kPink,
                                ),
                              );
                            },
                          ),
                          (ele['caption'] != null)
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(ele['caption']))
                              : const Text(''),
                        ],
                      ),
                    ),
                    duration: const Duration(seconds: 5))
                : StoryItem(
                    VideoPlayerController.networkUrl(ele['content']) as Widget,
                    duration: const Duration(seconds: 5)))
            .toList(),
      ),
    );
  }
}
