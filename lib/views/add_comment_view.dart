import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/widgets/user_comment.dart';

class AddCommentView extends StatelessWidget {
  const AddCommentView({super.key});
  static String addCommentView = 'Add comment screen';
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kBlack,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: hight * 0.01,
                ),
                Row(
                  children: [
                    IconButton(
                      padding:
                          const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text(
                      'Comment',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: hight * 0.03,
                ),
                const UserComment(),
                SizedBox(
                  height: hight * 0.022,
                ),
                const UserComment(),
                SizedBox(
                  height: hight * 0.022,
                ),
                const UserComment(),
                SizedBox(
                  height: hight * 0.022,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
