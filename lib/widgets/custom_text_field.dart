import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.hint,
      this.obsecure = false});
  final String label;
  final String hint;
  final bool obsecure;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecure,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPink,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
