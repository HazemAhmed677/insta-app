import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/widgets/custom_search_text_field.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static String searchId = 'Search page';
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: hight * 0.02,
            ),
            const CustomSearchTextField(),
            SizedBox(
              height: hight * 0.025,
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                    kImage,
                  ),
                  radius: 26,
                ),
                SizedBox(width: width * 0.03),
                const Text(
                  'Hazem',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            SizedBox(
              height: hight * 0.02,
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                    kImage,
                  ),
                  radius: 26,
                ),
                SizedBox(width: width * 0.03),
                const Text(
                  'Hazem',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
