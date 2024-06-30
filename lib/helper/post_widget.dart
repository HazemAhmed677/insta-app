import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class CustomPostWidget extends StatelessWidget {
  const CustomPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
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
        Image.asset(kImage),
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
      ],
    );
  }
}
