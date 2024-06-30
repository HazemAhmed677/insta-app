import 'package:flutter/material.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});
  static String addPostId = 'Search page';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              onPressed: () {},
              icon: const Icon(Icons.cancel),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: const Text(
                'New Post',
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: const Size(50, 30),
                ),
                onPressed: () {},
                child: Text('Next'))
          ],
        )
      ],
    );
  }
}
