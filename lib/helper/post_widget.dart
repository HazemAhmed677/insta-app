import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/views/add_comment_view.dart';

class CustomPostWidget extends StatefulWidget {
  const CustomPostWidget({super.key});

  @override
  State<CustomPostWidget> createState() => _CustomPostWidgetState();
}

class _CustomPostWidgetState extends State<CustomPostWidget> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(kImage),
              maxRadius: 34,
            ),
            SizedBox(
              width: 0.035 * width,
            ),
            const Text(
              'Hazem',
              style: TextStyle(
                color: kWhite,
                fontSize: 22,
              ),
            )
          ],
        ),
        SizedBox(
          height: 0.02 * hight,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            kImage,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            IconButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(10, 10),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  isLiked = !isLiked;
                  setState(() {});
                },
                icon: Icon(
                  Icons.favorite,
                  color: (isLiked) ? kPink : null,
                  size: 28,
                )),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(20, 10),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.comment,
                  size: 26,
                ))
          ],
        ),
        SizedBox(
          height: 0.016 * hight,
        ),
        const Text(
          '677 Likes',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const Text(
          'Goat',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 1, right: 4),
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddCommentView.addCommentView);
          },
          child: const Text(
            'Add comment',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          height: 0.02 * hight,
        ),
      ],
    );
  }
}
