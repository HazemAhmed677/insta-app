import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.obsecure = false,
    this.onTap,
    this.autoFocus = false,
    this.passwordIcon,
    this.validator,
    required this.flag,
    required this.autovalidateMode,
  });
  final String label;
  final String hint;
  final bool obsecure;
  final bool autoFocus;
  final IconButton? passwordIcon;
  final Function()? onTap;
  final String? Function(String?)? validator;
  AutovalidateMode autovalidateMode;
  bool flag;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autovalidateMode,
      onChanged: (input) {
        if (widget.label == 'username') {
          if (input.isNotEmpty && input.length >= 4) {
            widget.autovalidateMode = AutovalidateMode.disabled;
            widget.flag = true;
          } else if (widget.flag) {
            setState(() {});
          }
        } else if (widget.label == 'email') {
          if (input.isNotEmpty && input.contains('@')) {
            widget.autovalidateMode = AutovalidateMode.disabled;
            widget.flag = true;
          } else if (widget.flag) {
            setState(() {});
          }
        } else {
          if (input.isNotEmpty && input.length >= 8) {
            widget.autovalidateMode = AutovalidateMode.disabled;
            widget.flag = true;
          } else if (widget.flag) {
            widget.autovalidateMode = AutovalidateMode.disabled;
            setState(() {});
          }
        }
      },
      validator: widget.validator,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      obscureText: widget.obsecure,
      decoration: InputDecoration(
        suffixIcon: widget.passwordIcon,
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
