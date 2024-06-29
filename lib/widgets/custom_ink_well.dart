import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.88),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
      ),
    );
  }
}
