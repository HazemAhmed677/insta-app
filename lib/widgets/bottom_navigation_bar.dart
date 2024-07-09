import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int index = BlocProvider.of<SwitchScreensCubit>(context).currentIndex;
    return CurvedNavigationBar(
      height: 66,
      key: bottomNavigationKey,
      index: BlocProvider.of<SwitchScreensCubit>(context).currentIndex,
      items: const <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 4.0),
          child: Icon(FontAwesomeIcons.house, size: 24),
        ),
        Icon(FontAwesomeIcons.magnifyingGlass, size: 24),
        Icon(FontAwesomeIcons.facebookMessenger, size: 24),
        Icon(FontAwesomeIcons.plus, size: 24),
        Icon(FontAwesomeIcons.user, size: 24),
      ],
      color: const Color.fromARGB(255, 29, 28, 28),
      buttonBackgroundColor: (index == 0)
          ? kPink.shade900
          : (index == 1)
              ? Colors.green.shade800
              : (index == 2)
                  ? Colors.blue.shade900
                  : (index == 3)
                      ? Colors.yellow.shade900
                      : Colors.red.shade900,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) {
        BlocProvider.of<SwitchScreensCubit>(context).currentIndex = index;
        BlocProvider.of<SwitchScreensCubit>(context).getScreen();
        setState(() {});
      },
      letIndexChange: (index) => true,
    );
  }
}
