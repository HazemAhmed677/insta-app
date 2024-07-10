import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class StoriesBar extends StatelessWidget {
  const StoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: (index != 7)
              ? const EdgeInsets.only(
                  right: 18.0,
                )
              : EdgeInsets.zero,
          child: const Column(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: kWhite,
                child: CircleAvatar(
                  backgroundImage: AssetImage(kNullImage),
                  radius: 40,
                ),
              ),
              Text(
                'Story',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        );
      },
    );
  }
}
