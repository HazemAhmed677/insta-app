import 'package:flutter/material.dart';
import 'package:insta_app/models/user_model.dart';

class PersonInSearch extends StatelessWidget {
  const PersonInSearch({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: (user.profileImageURL != null)
              ? NetworkImage(user.profileImageURL!)
              : null,
          radius: 26,
        ),
        SizedBox(width: width * 0.03),
        Text(
          user.username,
          style: const TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: width * 0.5,
        ),
        Align(
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
