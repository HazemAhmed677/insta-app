import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/views/add_post_view.dart';
import 'package:insta_app/views/home_view.dart';
import 'package:insta_app/views/profile_view.dart';
import 'package:insta_app/views/search_view.dart';
import 'package:insta_app/views/sign_in_view.dart';
import 'package:insta_app/views/sign_up_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const InstaApp());
}

class InstaApp extends StatelessWidget {
  const InstaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SwitchScreensCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        routes: {
          SignUp.signUpId: (context) => const SignUp(),
          SignIn.signInId: (context) => const SignIn(),
          HomeView.homeViewId: (context) => const HomeView(),
          SearchView.searchId: (context) => const SearchView(),
          AddPostView.addPostId: (context) => const AddPostView(),
          ProfileView.profileId: (context) => const ProfileView()
        },
        initialRoute: HomeView.homeViewId,
      ),
    );
  }
}
