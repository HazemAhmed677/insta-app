import 'package:flutter/material.dart';

class ChatBubbleFromMe extends StatelessWidget {
  const ChatBubbleFromMe({super.key, required this.messege});
  final String messege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding:
            const EdgeInsets.only(top: 18, bottom: 18, left: 15, right: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
            bottomLeft: Radius.circular(35),
          ),
          color: Color.fromARGB(255, 52, 96, 137),
        ),
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

class ChatBubbleFromFriend extends StatelessWidget {
  const ChatBubbleFromFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding:
            const EdgeInsets.only(top: 18, bottom: 18, left: 15, right: 20),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            color: Colors.grey.shade800),
        child: const Text(
          'From my friend',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
