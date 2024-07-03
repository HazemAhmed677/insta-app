import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class UserComment extends StatelessWidget {
  const UserComment({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(kImage),
        ),
        SizedBox(
          width: width * 0.03,
        ),
        const Column(
          children: [
            Text(
              'Name',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Connected',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
      ],
    );
  }
}
