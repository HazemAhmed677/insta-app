import 'package:flutter/material.dart';

const kImage = 'assets/images/logo.jpg';
const kPink = Colors.pink;
const kPuple = Color.fromARGB(255, 198, 115, 221);
const kBlack = Colors.black;
const kWhite = Colors.white;
Future<void> kAnimateTo(ScrollController controller) async {
  return await controller.animateTo(
    controller.position.maxScrollExtent,
    duration: const Duration(milliseconds: 100),
    curve: Curves.linear,
  );
}
