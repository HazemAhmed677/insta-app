import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screen_cubit_states.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/views/add_post_view.dart';
import 'package:insta_app/views/all_chats_view.dart';
import 'package:insta_app/views/home_view.dart';
import 'package:insta_app/views/profile_view.dart';
import 'package:insta_app/views/search_view.dart';

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
    return CurvedNavigationBar(
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
    );

    // BottomNavigationBarItem getBNBItem(
    //     IconData icon, String label, int current, String view) {
    //   return BottomNavigationBarItem(
    //     icon: IconButton(
    //       padding: EdgeInsets.zero,
    //       constraints:
    //           const BoxConstraints(), // override default min size of 48px
    //       style: const ButtonStyle(
    //         tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
    //       ),
    //       onPressed: () {
    //         BlocProvider.of<SwitchScreensCubit>(context).currentIndex = current;
    //         BlocProvider.of<SwitchScreensCubit>(context).getScreen();
    //       },
    //       icon: Icon(
    //         icon,
    //       ),
    //     ),
    //     label: label,
    //   );
    // }

    // return SizedBox(
    //   height: 79,
    //   child: BlocBuilder<SwitchScreensCubit, SwitchScreensStates>(
    //     builder: (context, state) {
    //       return BottomNavigationBar(
    //         currentIndex:
    //             BlocProvider.of<SwitchScreensCubit>(context).currentIndex,
    //         // 88888888
    //         backgroundColor: kBlack,
    //         selectedFontSize: 16,
    //         selectedIconTheme: const IconThemeData(
    //           size: 40,
    //           color: kPink,
    //         ),
    //         // 888888888888
    //         unselectedLabelStyle: const TextStyle(color: kBlack),
    //         type: BottomNavigationBarType.fixed,
    //         fixedColor: kWhite,
    //         items: [
    //           getBNBItem(Icons.home, 'Home', 0, HomeView.homeViewId),
    //           getBNBItem(Icons.search, 'Search', 1, SearchView.searchId),
    //           getBNBItem(
    //               Icons.message, 'Chats', 2, AllChatsView.allChatsViewID),
    //           getBNBItem(Icons.add, 'Post', 3, AddPostView.addPostId),
    //           getBNBItem(Icons.person, 'Profile', 4, ProfileView.profileId),
    //         ],
    //         onTap: (value) {
    //           BlocProvider.of<SwitchScreensCubit>(context).currentIndex = value;
    //           BlocProvider.of<SwitchScreensCubit>(context).getScreen();
    //         },
    //       );
    //     },
    //   ),
    // );
    // }
  }
}
