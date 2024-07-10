import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/views/chat_view.dart';

class PersonInSearch extends StatelessWidget {
  const PersonInSearch(
      {super.key,
      required this.username,
      required this.imageURL,
      required this.currentUserID,
      required this.searchedUser});
  final String username;
  final String? imageURL;
  final String currentUserID;
  final UserModel searchedUser;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: (imageURL != null)
              ? CachedNetworkImageProvider(imageURL!)
              : const AssetImage(kNullImage),
          radius: 28,
        ),
        SizedBox(width: width * 0.02),
        Text(
          username,
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Get.to(
              ChatView(
                  currentUserID: currentUserID, recieverUser: searchedUser),
              transition: Transition.rightToLeft,
            );
          },
          icon: const Icon(
            FontAwesomeIcons.solidMessage,
            color: Colors.blueAccent,
            size: 20,
          ),
        )
      ],
    );
  }
}
