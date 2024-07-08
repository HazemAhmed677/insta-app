import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/chat_bubble.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});
  static String chatViewID = 'Chat view';
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
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(kImage),
                          radius: 26,
                        ),
                        SizedBox(width: width * 0.03),
                        const Text(
                          'name',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ChatBubbleFromMe();
                    }),
              ),
              // *************************
              // *************************
              //TEXT FIELD
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  top: 18,
                ),
                child: TextField(
                  cursorColor: const Color.fromARGB(255, 0, 140, 255),
                  onSubmitted: (value) {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    prefixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.image,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                    ),
                    hintText: 'Messege',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: kWhite,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
