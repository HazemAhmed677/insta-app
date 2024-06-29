import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/screens/sign_up.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';
import 'package:insta_app/widgets/custom_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  static String signInId = 'Sign in page';
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
                height: 140,
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
              CustomTextField(
                label: 'email',
                hint: 'Enter email',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'password',
                hint: 'Enter password',
                obsecure: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: CustomInkWell(text: 'Sign In'),
              ),
              SizedBox(
                width: 90,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.pushNamed(context, SignUp.signUpId);
                  },
                  child: const Center(
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
