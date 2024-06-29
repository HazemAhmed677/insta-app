import 'package:flutter/material.dart';
import 'package:insta_app/views/home_view.dart';
import 'package:insta_app/views/sign_in_view.dart';
import 'package:insta_app/views/sign_up_view.dart';

void main() {
  runApp(const InstaApp());
}

class InstaApp extends StatelessWidget {
  const InstaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      routes: {
        SignUp.signUpId: (context) => const SignUp(),
        SignIn.signInId: (context) => const SignIn(),
        HomeView.homeViewId: (context) => const HomeView(),
      },
      initialRoute: SignIn.signInId,
    );
  }
}
