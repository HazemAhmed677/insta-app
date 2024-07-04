import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screen_cubit_states.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/helper/modal_progress_hud_helper.dart';
import 'package:insta_app/helper/show_snack_bar_function.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:uuid/uuid.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});
  static String addPostId = 'Search page';

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  File? imagePost;
  String? description;
  late String imageURL;

  Future<void> selectImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      imagePost = File(image.path);
      setState(() {});
    }
  }

  TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return ModalProgressHudHelper(
      isLoading: isLoading,
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
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          imagePost = null;
                          textEditingController.clear();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.cancel,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          'New Post',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size(
                            50,
                            30,
                          ),
                        ),
                        onPressed: () async {
                          if (imagePost != null) {
                            try {
                              isLoading = true;
                              setState(() {});

                              String generatedID = const Uuid().v4();
                              var reff = FirebaseStorage.instance
                                  .ref(kPostsImages)
                                  .child(generatedID);
                              await reff.putFile(imagePost!);
                              imageURL = await reff.getDownloadURL();
                              description = textEditingController.text;
                              PostModel postModel = PostModel(
                                userID: FirebaseAuth.instance.currentUser!.uid,
                                imageURL: imageURL,
                                likes: [],
                                desciption: description,
                                postID: generatedID,
                                timestamp: Timestamp.now(),
                              );
                              Map<String, dynamic> postMap =
                                  postModel.convertToMap(postModel);
                              await FirebaseFirestore.instance
                                  .collection(kPosts)
                                  .doc(generatedID)
                                  .set(postMap);
                              isLoading = false;
                              textEditingController.clear();
                              imagePost = null;
                              setState(() {});
                              BlocProvider.of<SwitchScreensCubit>(context)
                                  .currentIndex = 0;
                              BlocProvider.of<SwitchScreensCubit>(context)
                                  .getScreen();
                            } catch (e) {
                              print(e.toString());
                            }

                            getShowSnackBar(context, 'Post added successfully');
                          } else {
                            getShowSnackBar(context, 'upload an image');
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
                  (imagePost != null)
                      ? Column(
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.file(
                                  imagePost!,
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
                  SizedBox(
                    height: hight * 0.058,
                    child: ElevatedButton(
                      onPressed: () async {
                        await selectImage();
                      },
                      child: const Center(
                        child: Icon(
                          Icons.file_upload_sharp,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hight * 0.014,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: textEditingController,
                      cursorColor: kPink,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        hintText: 'Describtion...',
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
