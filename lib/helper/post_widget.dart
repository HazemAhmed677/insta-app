import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class CustomPostWidget extends StatelessWidget {
  const CustomPostWidget({super.key});

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
        Image.asset(
          kImage,
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Icon(Icons.favorite),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.comment)
          ],
        ),
        SizedBox(
          height: 0.02 * hight,
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
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft),
          onPressed: () {},
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
