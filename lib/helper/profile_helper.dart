import 'package:flutter/material.dart';

class ProfileHelper extends StatelessWidget {
  const ProfileHelper({super.key, required this.number, required this.text});
  final String number;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(children: [
        Text(
          number,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
