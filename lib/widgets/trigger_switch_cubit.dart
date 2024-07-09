import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_cubit.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screen_cubit_states.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/views/add_post_view.dart';
import 'package:insta_app/views/profile_view.dart';
import 'package:insta_app/views/search_view.dart';
import 'package:insta_app/widgets/bottom_navigation_bar.dart';
import 'package:insta_app/widgets/custom_home_view.dart';

class TriggerSwitchCubit extends StatefulWidget {
  const TriggerSwitchCubit({super.key});

  @override
  State<TriggerSwitchCubit> createState() => _TriggerSwitchCubitState();
}

class _TriggerSwitchCubitState extends State<TriggerSwitchCubit> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchSearchedUsersCubit(),
        ),
      ],
      child: BlocBuilder<SwitchScreensCubit, SwitchScreensStates>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: kBlack,
              body: (state is HomeScreenState)
                  ? const CustomHomeView()
                  : (state is SearchScreenState)
                      ? const SearchView()
                      : (state is AddPostScreenState)
                          ? const AddPostView()
                          : StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(kUsers)
                                  .doc(
                                    FirebaseAuth.instance.currentUser!.uid,
                                  )
                                  .snapshots(),
                              builder: (context, snapshot) {
                                Map<String, dynamic> userMap = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                UserModel user = UserModel.fromJson(userMap);
                                return ProfileView(
                                    bar: "Edit profile", userModel: user);
                              }),
              bottomNavigationBar: const CustomBottomNavigationBar(),
            ),
          );
        },
      ),
    );
  }
}
