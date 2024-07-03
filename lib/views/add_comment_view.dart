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
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text(
                      'Comments',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: hight * 0.02,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: hight * 0.011),
                          child: const UserComment(),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 18),
                  child: TextField(
                    cursorColor: kPink,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                      ),
                      hintText: 'Add comment',
                      suffixIconColor: const Color.fromARGB(255, 62, 146, 214),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: kWhite,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: kPink,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
