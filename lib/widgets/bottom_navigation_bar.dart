import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/views/add_post_view.dart';
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
  @override
  Widget build(BuildContext context) {
    BottomNavigationBarItem getBNBItem(
        IconData icon, String label, int current, String view) {
      return BottomNavigationBarItem(
        icon: IconButton(
          padding: EdgeInsets.zero,
          constraints:
              const BoxConstraints(), // override default min size of 48px
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
          ),
          onPressed: () {
            BlocProvider.of<SwitchScreensCubit>(context).currentIndex = current;
            setState(() {});
          },
          icon: Icon(
            icon,
          ),
        ),
        label: label,
      );
    }

    return SizedBox(
      height: 79,
      child: BottomNavigationBar(
        currentIndex: BlocProvider.of<SwitchScreensCubit>(context).currentIndex,
        backgroundColor: kBlack,
        selectedFontSize: 16,
        selectedIconTheme: const IconThemeData(
          size: 40,
          color: kPink,
        ),
        type: BottomNavigationBarType.fixed,
        fixedColor: kWhite,
        items: [
          getBNBItem(Icons.home, 'Home', 0, HomeView.homeViewId),
          getBNBItem(Icons.search, 'Search', 1, SearchView.searchId),
          getBNBItem(Icons.add, 'Post', 2, AddPostView.addPostId),
          getBNBItem(Icons.person, 'Profile', 3, ProfileView.profileId),
        ],
        onTap: (value) {
          BlocProvider.of<SwitchScreensCubit>(context).currentIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
