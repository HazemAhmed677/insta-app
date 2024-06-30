import 'package:flutter/material.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});
  static String addPostId = 'Search page';
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              icon: const Icon(Icons.cancel),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
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
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(
          height: hight * 0.4,
        ),
        Center(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.upload,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          height: hight * 0.02,
        ),
        Text('Add caption')
      ],
    );
  }
}
