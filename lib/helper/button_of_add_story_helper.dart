import 'package:flutter/material.dart';

class ButtonOfAddStoryHelper extends StatelessWidget {
  const ButtonOfAddStoryHelper(
      {super.key, required this.text, required this.icon, this.onTap});
  final String text;
  final Icon icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                offset: Offset(8, 8),
              )
            ]),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: Row(
              children: [
                icon,
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
