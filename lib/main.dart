import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:insta_app/cubits/fetch_all_comments_cubit/fetch_all_comments_cubit.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screens_cubit.dart';
import 'package:insta_app/views/add_comment_view.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SwitchScreensCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileImageCubit(),
        ),
        BlocProvider(
          create: (context) => FetchUserDataCubit(),
        ),
        BlocProvider(
          create: (context) => FetchAllCommentsCubit(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        routes: {
          SignUp.signUpId: (context) => const SignUp(),
          SignIn.signInId: (context) => const SignIn(),
          HomeView.homeViewId: (context) => const HomeView(),
          SearchView.searchId: (context) => const SearchView(),
          AddPostView.addPostId: (context) => const AddPostView(),
          ProfileView.profileId: (context) => const ProfileView(),
          AddCommentView.addCommentView: (context) => const AddCommentView(),
        },
        initialRoute: HomeView.homeViewId,
      ),
    );
  }
}
