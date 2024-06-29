import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';
import 'package:insta_app/widgets/custom_text_field.dart';
import 'package:insta_app/widgets/sign_up_word.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static String signInId = 'Sign in page';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            controller: controller,
            children: [
              SizedBox(
                height: 0.16 * MediaQuery.of(context).size.height,
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
              const CustomTextField(
                label: 'email',
                hint: 'Enter email',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                onTap: () {
                  controller.animateTo(
                    controller.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.linear,
                  );
                },
                label: 'password',
                hint: 'Enter password',
                obsecure: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: CustomInkWell(text: 'Log in'),
              ),
              const SignUpWord(),
            ],
          ),
        ),
      ),
    );
  }
}
