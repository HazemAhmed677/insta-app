import 'package:flutter/material.dart';

const kImage = 'assets/images/logo.jpg';
const kNullImage = 'assets/images/images.png';
const kPink = Colors.pink;
const kPuple = Color.fromARGB(255, 198, 115, 221);
const kBlack = Colors.black;
const kWhite = Colors.white;
const kUsers = 'users';
const kPosts = 'posts';
const kChats = 'chats';
const kMesseges = 'messeges';
const kImages = 'images';
const kStories = 'Stories';
const kLoadingPhoto = 'assets/images/th.jpg';
const kComments = 'comments';
const kPostsImages = 'posts_images';
Future<void> kAnimateTo(ScrollController controller) async {
  return await controller.animateTo(
    controller.position.maxScrollExtent,
    duration: const Duration(milliseconds: 100),
    curve: Curves.linear,
  );
}

String kChatRoomID(
    {required String currentUserID, required String chatedOneID}) {
  String roomID = '${currentUserID}_$chatedOneID';
  List<String> chars = roomID.split('');

  chars.sort();

  String roomIDSorted = chars.join('');
  return roomIDSorted;
}
