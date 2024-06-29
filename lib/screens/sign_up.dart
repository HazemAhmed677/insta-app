import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';
import 'package:insta_app/widgets/custom_question_text.dart';
import 'package:insta_app/widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static String signUpId = 'Sign up page';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ScrollController controller = ScrollController();
  Future<void> animateTo() {
    return controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

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
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'PlaywriteMX',
                  ),
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
                onTap: () async {
                  await animateTo();
                },
                label: 'username',
                hint: 'Enter username',
                autoFocus: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                onTap: () async {
                  await animateTo();
                },
                label: 'email',
                hint: 'Enter email',
                autoFocus: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                onTap: () async {
                  await animateTo();
                  setState(() {});
                },
                label: 'password',
                hint: 'Enter password',
                autoFocus: true,
                obsecure: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: CustomInkWell(text: 'Sign up'),
              ),
              Align(
                alignment: Alignment.center,
                child: CustomQuestionText(
                  question: 'do you have an account?',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
