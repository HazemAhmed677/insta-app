import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/screens/sign_in.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';
import 'package:insta_app/widgets/custom_question_text.dart';
import 'package:insta_app/widgets/custom_text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  static String signUpId = 'Sign up page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 145,
              ),
              const Center(
                child: Text(
                  'Insta',
                  style: TextStyle(fontSize: 40, fontFamily: 'PlaywriteMX'),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  kLogo,
                  height: 90,
                  width: 90,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const CustomTextField(label: 'username', hint: 'Enter username'),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                label: 'email',
                hint: 'Enter email',
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                label: 'password',
                hint: 'Enter password',
                obsecure: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: CustomInkWell(text: 'Sign up'),
              ),
              CustomQuestionText(
                onTap: () {
                  Navigator.pushNamed(context, SignIn.signInId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
