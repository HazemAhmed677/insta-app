import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screen_cubit_states.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/helper/button_of_add_story_helper.dart';
import 'package:insta_app/helper/modal_progress_hud_helper.dart';
import 'package:insta_app/helper/show_snack_bar_function.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class AddStoryView extends StatefulWidget {
  const AddStoryView({super.key, required this.userModel});
  static String addPostId = 'Search page';
  final UserModel userModel;

  @override
  State<AddStoryView> createState() => _AddStoryViewState();
}

class _AddStoryViewState extends State<AddStoryView> {
  File? imageFile;
  File? videoFile;
  String? imageURL;
  String? videoURL;
  bool isLoading = false;
  bool isAbsorb = false;
  VideoPlayerController? videoPlayerController;
  bool? isPlaying;
  String? caption;
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectImage() async {
      XFile? image;
      try {
        image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          imageFile = File(image.path);
          videoFile = null;

          setState(() {
            isPlaying = null;
            videoPlayerController!.pause();
          });
        }
      } catch (e) {
        // getShowSnackBar(context, 'wait please');
      }
    }

    Future<void> selectVideo() async {
      XFile? video;
      try {
        video = await ImagePicker().pickVideo(
          source: ImageSource.gallery,
        );
        if (video != null) {
          videoFile = File(video.path);
          imageFile = null;

          setState(
            () {
              isPlaying = true;
              videoPlayerController = VideoPlayerController.file(videoFile!);
              videoPlayerController!.initialize();
              videoPlayerController!.play();
            },
          );
        }
      } catch (e) {
        // getShowSnackBar(context, 'wait please');
      }
    }

    Future<void> uploadStoryItemToFirebase() async {
      if (imageFile != null && videoFile == null) {
        String generatedID = const Uuid().v4();
        var reff = FirebaseStorage.instance.ref(kStories).child(generatedID);
        await reff.putFile(imageFile!);
        imageURL = await reff.getDownloadURL(); // you got url of image
        StoryModel story = StoryModel(
          caption: caption,
          content: imageURL!,
          storyID: generatedID,
          type: 'image',
          uid: widget.userModel.uid,
          date: Timestamp.now(),
        );

        Map<String, dynamic> storyMap = story.convertToMap(story);
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(widget.userModel.uid)
            .update(
          {
            'stories': FieldValue.arrayUnion([storyMap]),
          },
        );
        videoPlayerController!.pause();
      } else if (videoFile != null && imageFile == null) {
        String generatedID = const Uuid().v4();
        var reff = FirebaseStorage.instance.ref(kStories).child(generatedID);
        await reff.putFile(videoFile!);
        videoURL = await reff.getDownloadURL(); // you got video url

        StoryModel story = StoryModel(
          caption: caption,
          content: videoURL!,
          storyID: generatedID,
          type: 'video',
          uid: widget.userModel.uid,
          date: Timestamp.now(),
        );
        widget.userModel.stories!.add(story.convertToMap(story));
        Map<String, dynamic> storyMap = story.convertToMap(story);
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(widget.userModel.uid)
            .update(
          {
            'stories': FieldValue.arrayUnion([storyMap]),
          },
        );
        caption = null;
      }
    }

    double hight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ModalProgressHudHelper(
            isLoading: isLoading,
            child: AbsorbPointer(
              absorbing: isAbsorb,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SingleChildScrollView(
                  child: BlocBuilder<SwitchScreensCubit, SwitchScreensStates>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                style: const ButtonStyle(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  imageFile = null;
                                  videoFile = null;
                                  videoPlayerController?.pause() ?? true;
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'New Story',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: const Size(
                                    50,
                                    30,
                                  ),
                                ),
                                onPressed: () async {
                                  if (imageFile != null || videoFile != null) {
                                    try {
                                      isAbsorb = true;
                                      isLoading = true;
                                      setState(() {});

                                      await uploadStoryItemToFirebase();
                                    } catch (e) {
                                      // print(e.toString());
                                    }
                                    textEditingController.clear();

                                    imageFile = null;
                                    videoFile = null;
                                    isAbsorb = false;
                                    isLoading = false;
                                    setState(() {});
                                    getShowSnackBar(
                                        context, 'Story added successfully');
                                  } else {
                                    getShowSnackBar(
                                        context, 'upload an image or video');
                                  }
                                },
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kPink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: hight * 0.028,
                          ),
                          (imageFile != null || videoFile != null)
                              ? Column(
                                  children: [
                                    (imageFile != null)
                                        ? Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: Image.file(
                                                imageFile!,
                                                height: hight * 0.67,
                                              ),
                                            ),
                                          )
                                        : Stack(
                                            children: [
                                              SizedBox(
                                                height: hight * 0.67,
                                                child: VideoPlayer(
                                                  videoPlayerController!,
                                                ),
                                              ),
                                              (isPlaying!)
                                                  ? Positioned(
                                                      bottom: 4,
                                                      left: 2,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          isPlaying =
                                                              !isPlaying!;
                                                          videoPlayerController!
                                                              .pause();
                                                          setState(() {});
                                                        },
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .pause),
                                                      ),
                                                    )
                                                  : Positioned(
                                                      bottom: 4,
                                                      left: 2,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          isPlaying =
                                                              !isPlaying!;
                                                          videoPlayerController!
                                                              .play();
                                                          setState(() {});
                                                        },
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .play),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                    SizedBox(
                                      height: hight * 0.02,
                                    ),
                                  ],
                                )
                              : SizedBox(height: hight * 0.69),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonOfAddStoryHelper(
                                  onTap: () async {
                                    await selectImage();
                                    setState(() {});
                                  },
                                  text: 'upload image',
                                  icon: const Icon(FontAwesomeIcons.image,
                                      color: Colors.lightGreenAccent),
                                ),
                                ButtonOfAddStoryHelper(
                                  onTap: () async {
                                    await selectVideo();
                                    setState(() {});
                                  },
                                  text: 'upload video',
                                  icon: const Icon(
                                    FontAwesomeIcons.video,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: hight * 0.02,
                          ),
                          TextField(
                            controller: textEditingController,
                            onChanged: (value) {
                              caption = value;
                            },
                            cursorColor: kPink,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              hintText: 'Add a caption...',
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPink,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPink,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
