import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/modal_progress_hud_helper.dart';
import 'package:insta_app/helper/show_snack_bar_function.dart';
import 'package:insta_app/models/user_model.dart';
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
            return const Text('');
          }
          if (snapshot.hasError) {
            return getShowSnackBar(context, 'error occured');
          }
          if (snapshot.data == null) {
            return const SignIn();
          }
          if (snapshot.hasData) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(kUsers)
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                return (snapshot.hasData)
                    ? TriggerSwitchCubit(
                        user: UserModel.fromJson(snapshot.data!.data()),
                      )
                    : const ModalProgressHudHelper(
                        isLoading: true,
                        child: Scaffold(
                          backgroundColor: kBlack,
                        ),
                      );
              },
            );
          }
          return const SizedBox();
        });
  }
}
