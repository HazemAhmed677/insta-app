import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: BottomNavigationBar(
        elevation: 20,
        showSelectedLabels: true,
        selectedIconTheme: const IconThemeData(
          size: 40,
          shadows: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 20,
              spreadRadius: 20,
            ),
          ],
          color: kPink,
        ),
        type: BottomNavigationBarType.fixed,
        fixedColor: kWhite,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: kWhite,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: kWhite,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home, color: kWhite),
            ),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
