import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/constants.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});
  static String addPostId = 'Search page';

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  File? imagePost;
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
                onPressed: () {},
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
                onPressed: () {},
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
            height: hight * 0.018,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: TextField(
              cursorColor: kPink,
              maxLines: 12,
              decoration: InputDecoration(
                hintText: 'Add caption',
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
