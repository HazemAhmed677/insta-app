import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_cubit.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screen_cubit_states.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/helper/delete_story_after24_function.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/views/add_post_view.dart';
import 'package:insta_app/views/all_chats_view.dart';
import 'package:insta_app/views/profile_view.dart';
import 'package:insta_app/views/search_view.dart';
import 'package:insta_app/widgets/bottom_navigation_bar.dart';
import 'package:insta_app/widgets/custom_home_view.dart';

class TriggerSwitchCubit extends StatefulWidget {
  const TriggerSwitchCubit({super.key, required this.user});

  final UserModel user;
  @override
  State<TriggerSwitchCubit> createState() => _TriggerSwitchCubitState();
}

class _TriggerSwitchCubitState extends State<TriggerSwitchCubit> {
  @override
  void initState() {
    super.initState();
    if (widget.user.stories?.isNotEmpty ?? false) {
      deleteStories(
        widget.user.stories!,
        widget.user,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchSearchedUsersCubit(),
      child: SafeArea(
        child: BlocBuilder<SwitchScreensCubit, SwitchScreensStates>(
          builder: (context, state) {
            return Scaffold(
              extendBody: true,
              backgroundColor: kBlack,
              body: AnimatedOpacity(
                opacity: 1,
                duration: const Duration(seconds: 10),
                child: (state is HomeScreenState)
                    ? CustomHomeView(
                        currentUser: widget.user,
                      )
                    : (state is SearchScreenState)
                        ? SearchView(
                            currentUser: widget.user,
                          )
                        : (state is AllChatsScreenState)
                            ? const AllChatsView()
                            : (state is AddPostScreenState)
                                ? const AddPostView()
                                : ProfileView(
                                    userModel: widget.user,
                                  ),
              ),
              bottomNavigationBar: const CustomBottomNavigationBar(),
            );
          },
        ),
      ),
    );
  }
}
