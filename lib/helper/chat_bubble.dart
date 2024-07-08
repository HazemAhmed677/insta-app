import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class ChatBubbleFromMe extends StatelessWidget {
  const ChatBubbleFromMe({super.key, required this.messege});
  final String messege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding:
            const EdgeInsets.only(top: 14, bottom: 14, left: 14, right: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          color: Color.fromARGB(255, 52, 96, 137),
        ),
        child: Text(
          messege,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleFromFriend extends StatelessWidget {
  const ChatBubbleFromFriend({super.key, required this.messege});
  final String messege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding:
            const EdgeInsets.only(top: 14, bottom: 14, left: 14, right: 14),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: kPink.shade800),
        child: Text(
          messege,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
