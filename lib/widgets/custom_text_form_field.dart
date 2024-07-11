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
    this.onChange,
    this.textEditingController,
    this.autovalidateMode,
  });
  final String label;
  final String hint;
  final bool obsecure;
  final bool autoFocus;
  final IconButton? passwordIcon;
  final Function()? onTap;
  final String? Function(String?)? validator;
  Function(String)? onChange;
  final TextEditingController? textEditingController;
  final AutovalidateMode? autovalidateMode;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autovalidateMode,
      controller: widget.textEditingController,
      onChanged: widget.onChange,
      validator: widget.validator,
      autofocus: widget.autoFocus,
      obscureText: widget.obsecure,
      decoration: InputDecoration(
        suffixIcon: widget.passwordIcon,
        suffixIconColor: Colors.grey.shade400,
        label: Text(
          widget.label,
        ),
        hintText: widget.hint,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: kPuple,
          ),
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
