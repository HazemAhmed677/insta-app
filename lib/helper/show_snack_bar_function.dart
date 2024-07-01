import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

getShowSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      duration: const Duration(milliseconds: 1500),
      backgroundColor: kPink,
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          color: kWhite,
        ),
      ),
    ),
  );
}
