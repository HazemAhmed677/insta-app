import 'package:flutter/material.dart';
import 'package:insta_app/views/sign_up_view.dart';

class SignUpWord extends StatelessWidget {
  const SignUpWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 85,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 28.0),
          child: InkWell(
            highlightColor: const Color.fromARGB(255, 106, 115, 122),
            borderRadius: BorderRadius.circular(16),
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
