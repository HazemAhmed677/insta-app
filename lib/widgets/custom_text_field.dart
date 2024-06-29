import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obsecure = false,
    this.controller,
  });
  final String label;
  final String hint;
  final bool obsecure;
  final ScrollController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        if (widget.controller != null) {
          widget.controller!.animateTo(
            widget.controller!.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
        }
      },
      obscureText: widget.obsecure,
      decoration: InputDecoration(
        label: Text(widget.label),
        hintText: widget.hint,
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
