import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
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
                  description = null;
                  setState(() {});
                },
                icon: const Icon(Icons.cancel),
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
                  minimumSize: const Size(50, 30),
                ),
                onPressed: () async {
                  if (imagePost != null) {
                    String generatedID = const Uuid().v4();
                    var reff = FirebaseStorage.instance
                        .ref(kPostsImages)
                        .child(generatedID);
                    await reff.putFile(imagePost!);
                    imageURL = await reff.getDownloadURL();
                    PostModel postModel = PostModel(
                      userID: FirebaseAuth.instance.currentUser!.uid,
                      imageURL: imageURL,
                      likes: [],
                      desciption: description,
                      comments: [],
                    );
                    Map<String, dynamic> postMap =
                        postModel.convertToMap(postModel);
                    await FirebaseFirestore.instance
                        .collection(kPosts)
                        .add(postMap);
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
                          height: hight * 0.39,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: hight * 0.02,
                    ),
                  ],
                )
              : SizedBox(
                  height: hight * 0.41,
                ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              cursorColor: kPink,
              maxLines: 12,
              decoration: InputDecoration(
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
      ),
    );
  }
}
