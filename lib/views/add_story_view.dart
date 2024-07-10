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

class AddStoryView extends StatefulWidget {
  const AddStoryView({super.key, required this.userModel});
  static String addPostId = 'Search page';
  final UserModel userModel;

  @override
  State<AddStoryView> createState() => _AddStoryViewState();
}

class _AddStoryViewState extends State<AddStoryView> {
  File? storyImage;
  File? storyVideo;
  String? imageURL;
  String? videoURL;

  bool isLoading = false;
  bool isAbsorb = false;
  @override
  Widget build(BuildContext context) {
    Future<void> selectImage() async {
      XFile? image;
      try {
        image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          storyImage = File(image.path);
          storyVideo = null;
        }
      } catch (e) {
        // getShowSnackBar(context, 'wait please');
      }
    }

    Future<void> selectVideo() async {}

    Future<void> uploadStoryItemToFirebase() async {
      if (storyImage != null && storyVideo == null) {
        String generatedID = const Uuid().v4();
        var reff = FirebaseStorage.instance.ref(kStories).child(generatedID);
        await reff.putFile(storyImage!);
        imageURL = await reff.getDownloadURL();
        widget.userModel.stories!.add(storyImage);
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(widget.userModel.uid)
            .update(
          {
            'stories': FieldValue.arrayUnion([imageURL]),
          },
        );
      } else if (storyVideo != null && storyImage == null) {
        String generatedID = const Uuid().v4();
        var reff = FirebaseStorage.instance.ref(kStories).child(generatedID);
        await reff.putFile(storyVideo!);
        videoURL = await reff.getDownloadURL();
        widget.userModel.stories!.add(storyVideo);
        await FirebaseFirestore.instance
            .collection(kUsers)
            .doc(widget.userModel.uid)
            .update(
          {
            'stories': FieldValue.arrayUnion([videoURL]),
          },
        );
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
                                  storyImage = null;
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
                                  if (storyImage != null) {
                                    try {
                                      isAbsorb = true;
                                      isLoading = true;
                                      setState(() {});

                                      await uploadStoryItemToFirebase();
                                      if (mounted) {
                                        setState(() {
                                          BlocProvider.of<SwitchScreensCubit>(
                                                  context)
                                              .currentIndex = 0;
                                          BlocProvider.of<SwitchScreensCubit>(
                                                  context)
                                              .getScreen();
                                        });
                                      }
                                    } catch (e) {
                                      print(e.toString());
                                    }

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
                          (storyImage != null)
                              ? Column(
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Image.file(
                                          storyImage!,
                                          height: hight * 0.38,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hight * 0.01,
                                    ),
                                  ],
                                )
                              : SizedBox(height: hight * 0.39),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonOfAddStoryHelper(
                                  onTap: () {
                                    selectImage();
                                  },
                                  text: 'upload image',
                                  icon: const Icon(FontAwesomeIcons.image,
                                      color: Colors.lightGreenAccent),
                                ),
                                ButtonOfAddStoryHelper(
                                  onTap: () {
                                    selectVideo();
                                  },
                                  text: 'upload video',
                                  icon: const Icon(
                                    FontAwesomeIcons.video,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                              ],
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
