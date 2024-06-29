import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              kLogo,
              height: 130,
              width: 130,
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
