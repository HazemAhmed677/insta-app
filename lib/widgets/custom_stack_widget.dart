import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/profile_image_cubit/profile_image_cubit.dart';

class CustomStackWidget extends StatefulWidget {
  const CustomStackWidget({
    super.key,
  });
  @override
  State<CustomStackWidget> createState() => _CustomStackWidgetState();
}

class _CustomStackWidgetState extends State<CustomStackWidget> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    Future<void> selectImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          BlocProvider.of<ProfileImageCubit>(context).selectedImage =
              File(image.path);
          selectedImage = File(image.path);
        });
      }
    }

    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            backgroundImage:
                (selectedImage != null) ? FileImage(selectedImage!) : null,
            maxRadius: 48,
          ),
          Positioned(
            top: hight * 0.084,
            left: width * 0.086,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                await selectImage();
              },
              highlightColor: Colors.grey.shade400,
              icon: const Icon(
                Icons.add_a_photo_outlined,
                color: kPink,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
