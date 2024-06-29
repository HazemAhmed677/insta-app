import 'package:flutter/material.dart';
import 'package:insta_app/screens/sign_up.dart';

class SignUpWord extends StatelessWidget {
  const SignUpWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 90,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              Navigator.pushNamed(context, SignUp.signUpId);
            },
            child: const Center(
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
