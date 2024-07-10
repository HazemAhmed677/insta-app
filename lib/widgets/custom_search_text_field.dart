import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key, required this.onSubmitted});
  final Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: (value) {
      //   input = value;
      // },
      onSubmitted: onSubmitted, // }
      cursorColor: kPuple,
      decoration: const InputDecoration(
        hintText: 'Search',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
          borderSide: BorderSide(
            color: kWhite,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
          borderSide: BorderSide(color: kPuple),
        ),
      ),
    );
  }
}
