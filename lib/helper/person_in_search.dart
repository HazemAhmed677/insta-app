import 'package:flutter/material.dart';

class PersonInSearch extends StatelessWidget {
  const PersonInSearch(
      {super.key, required this.username, required this.imageURL});
  final String username;
  final String? imageURL;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: (imageURL != null) ? NetworkImage(imageURL!) : null,
          radius: 28,
        ),
        SizedBox(width: width * 0.03),
        Text(
          username,
          style: const TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: width * 0.5,
        ),
      ],
    );
  }
}
