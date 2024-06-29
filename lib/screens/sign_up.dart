import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/widgets/custom_text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 160,
            ),
            const Center(
              child: Text(
                'Insta',
                style: TextStyle(fontSize: 40, fontFamily: 'PlaywriteMX'),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                kLogo,
                height: 110,
                width: 110,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              hint: 'username',
            )
          ],
        ),
      ),
    );
  }
}
