import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class PersonTileForChats extends StatelessWidget {
  const PersonTileForChats(
      {super.key,
      this.profileImage,
      required this.username,
      required this.lastMsg});
  static String personTileID = 'Person tile for chats';
  final String? profileImage;
  final String username;
  final String lastMsg;

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundImage: (profileImage != null)
                ? CachedNetworkImageProvider(profileImage!)
                : const AssetImage(kNullImage),
          ),
          SizedBox(
            width: width * 0.025,
          ),
          SizedBox(
            width: width * 0.6,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, right: 4, bottom: 6, top: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      lastMsg,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          PopupMenuButton(
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            popUpAnimationStyle: AnimationStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut),
            elevation: 20,
            onSelected: (text) {
              if (text == 'Delete') {
              } else if (text == 'Block') {}
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Delete',
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Block',
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Block',
                      style: TextStyle(fontSize: 14, color: kPink),
                    ),
                  ),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
