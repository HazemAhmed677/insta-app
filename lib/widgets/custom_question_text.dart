import 'package:flutter/material.dart';

class CustomQuestionText extends StatelessWidget {
  const CustomQuestionText({super.key, required this.onTap});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Text(
          'do you have an account?',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
