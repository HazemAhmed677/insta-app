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
    this.onChange,
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
  Function(String)? onChange;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChange,
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: kPink),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPuple,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
