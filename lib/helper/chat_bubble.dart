import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:intl/intl.dart';

class ChatBubbleFromMe extends StatelessWidget {
  const ChatBubbleFromMe(
      {super.key, required this.messege, required this.sentAt});
  final String messege;
  final Timestamp sentAt;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    DateTime dateTime = sentAt.toDate();
    String dateFormated = DateFormat('HH:mm').format(dateTime);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.only(top: 14, bottom: 6, left: 14, right: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          color: Color.fromARGB(255, 52, 96, 137),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              messege,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: hight * 0.0042,
            ),
            Text(
              dateFormated,
              style: const TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatBubbleFromFriend extends StatelessWidget {
  const ChatBubbleFromFriend(
      {super.key, required this.messege, required this.sentAt});
  final String messege;
  final Timestamp sentAt;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    DateTime dateTime = sentAt.toDate();
    String dateFormated = DateFormat('HH:mm').format(dateTime);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.only(top: 14, bottom: 6, left: 14, right: 14),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: kPink.shade800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messege,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: hight * 0.002,
            ),
            Text(
              dateFormated,
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
