import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class UserComment extends StatefulWidget {
  const UserComment({super.key});

  @override
  State<UserComment> createState() => _UserCommentState();
}

class _UserCommentState extends State<UserComment> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(kImage),
        ),
        SizedBox(
          width: width * 0.025,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Connected',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            IconButton(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 8),
                constraints: const BoxConstraints(),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                )),
            Text(
              '49',
              style: TextStyle(fontSize: 15),
            )
          ],
        )
      ],
    );
  }
}
