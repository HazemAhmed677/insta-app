import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class CustomAllChatAppBar extends StatelessWidget {
  const CustomAllChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      shadowColor: kWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
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
    );
  }
}
