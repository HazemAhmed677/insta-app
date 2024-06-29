import 'package:flutter/material.dart';
import 'package:insta_app/screens/sign_in.dart';
import 'package:insta_app/screens/sign_up.dart';

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
      },
      initialRoute: SignUp.signUpId,
    );
  }
}
