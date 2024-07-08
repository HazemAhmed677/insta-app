import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/peson_tile_for_chats.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: hight * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      padding:
                          const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(FontAwesomeIcons.arrowLeft),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text(
                      'Chats',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: hight * 0.02,
              ),
              Expanded(
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const PersonTileForChats();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
