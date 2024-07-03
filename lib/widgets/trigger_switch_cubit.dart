import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screen_cubit_states.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/views/add_post_view.dart';
import 'package:insta_app/views/profile_view.dart';
import 'package:insta_app/views/search_view.dart';
import 'package:insta_app/widgets/bottom_navigation_bar.dart';
import 'package:insta_app/widgets/custom_home_view.dart';

class TriggerSwitchCubit extends StatelessWidget {
  const TriggerSwitchCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchScreensCubit, SwitchScreensStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: kBlack,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: (state is HomeScreenState)
                  ? const CustomHomeView()
                  : (state is SearchScreenState)
                      ? const SearchView()
                      : (state is AddPostScreenState)
                          ? const AddPostView()
                          : const ProfileView(),
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
          ),
        );
      },
    );
  }
}
