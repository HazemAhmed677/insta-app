import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/views/chat_view.dart';

class PersonTileForChats extends StatelessWidget {
  const PersonTileForChats({super.key});
  static String personTileID = 'Person tile for chats';
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        splashColor: kBlack,
        onTap: () {
          Navigator.pushNamed(context, ChatView.chatViewID);
        },
        child: Row(
          children: [
            const CircleAvatar(
              radius: 34,
              backgroundImage: AssetImage(kImage),
            ),
            SizedBox(
              width: width * 0.025,
            ),
            SizedBox(
              width: width * 0.6,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      'Last messege bitch',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PopupMenuButton(
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
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
      ),
    );
  }
}
