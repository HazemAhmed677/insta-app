import 'package:flutter/material.dart';

class CustomQuestionText extends StatelessWidget {
  const CustomQuestionText(
      {super.key, required this.onTap, required this.question});
  final Function()? onTap;
  final String question;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Text(
          question,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
