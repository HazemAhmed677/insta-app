import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';

class CustomCNBB extends StatefulWidget {
  const CustomCNBB({super.key});

  @override
  State<CustomCNBB> createState() => _CustomCNBBState();
}

class _CustomCNBBState extends State<CustomCNBB> {
  @override
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        //  code start i
        bottomNavigationBar: CurvedNavigationBar(
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
          color: const Color.fromARGB(255, 98, 0, 52),
          buttonBackgroundColor: kPink.shade800,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            BlocProvider.of<SwitchScreensCubit>(context).currentIndex = index;
            BlocProvider.of<SwitchScreensCubit>(context).getScreen();
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _page.toString(),
                  style: const TextStyle(
                    fontSize: 160,
                  ),
                ),
                ElevatedButton(
                  child: const Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState? navBarState =
                        bottomNavigationKey.currentState;
                    navBarState?.setPage(1);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
