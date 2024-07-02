import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/cubits/profile_image_cubit/profile_image_cubit_state.dart';
import 'package:insta_app/services/storage_cloud_service.dart';

class ProfileImageCubit extends Cubit<InitialProfileImageState> {
  ProfileImageCubit() : super(InitialProfileImageState());
  File? selectedImage;
  String? imageURL;
  addImageToStorage(String image, File file) async {
    Reference reff = FirebaseStorage.instance.ref('images').child(image);
    await reff.putFile(file);
    imageURL = await reff.getDownloadURL();
  }
}
