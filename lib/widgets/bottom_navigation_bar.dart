import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    BottomNavigationBarItem getBNBItem(
        IconData icon, String label, int current) {
      return BottomNavigationBarItem(
        icon: IconButton(
          onPressed: () {
            currentIndex = current;
            setState(() {});
          },
          icon: Icon(
            icon,
          ),
        ),
        label: label,
      );
    }

    return Container(
      height: hight * 0.1181,
      decoration: const BoxDecoration(color: Colors.white),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
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
          getBNBItem(Icons.home, 'Home', 0),
          getBNBItem(Icons.search, 'Search', 1),
          getBNBItem(Icons.add, 'Post', 2),
          getBNBItem(Icons.person, 'Profile', 3),
        ],
      ),
    );
  }
}
