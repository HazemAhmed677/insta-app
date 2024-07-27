import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/profile_image_cubit/profile_image_cubit.dart';

class CustomStackWidget extends StatefulWidget {
  const CustomStackWidget({
    super.key,
    required this.email,
  });
  final String? email;
  @override
  State<CustomStackWidget> createState() => _CustomStackWidgetState();
}

class _CustomStackWidgetState extends State<CustomStackWidget> {
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    Future<void> selectImage() async {
      XFile? image;
      try {
        image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
      } catch (e) {
        //
      }
      if (image != null) {
        selectedImage = File(image.path);
        setState(() {});
        BlocProvider.of<ProfileImageCubit>(context).selectedImage =
            selectedImage;
      }
    }

    return Align(
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            backgroundImage: (selectedImage != null && widget.email != null)
                ? FileImage(selectedImage!)
                : null,
            maxRadius: 48,
          ),
          Positioned(
            top: 70,
            left: 35,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                setState(() {});
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
