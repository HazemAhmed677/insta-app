import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/helper/show_snack_bar_function.dart';
import 'package:insta_app/views/sign_in_view.dart';
import 'package:insta_app/widgets/trigger_switch_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String homeViewId = 'Home view page';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: kPink,
            );
          }
          if (snapshot.hasError) {
            return getShowSnackBar(context, ' error occured');
          }
          if (snapshot.data == null) {
            return const SignIn();
          }
          if (snapshot.hasData) {
            return const TriggerSwitchCubit();
          }
          return const SizedBox();
        });
  }
}
