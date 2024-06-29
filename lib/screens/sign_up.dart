import 'package:flutter/material.dart';
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

  bool obsecure = true;
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
                height: 0.13 * MediaQuery.of(context).size.height,
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
                height: 16,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                maxRadius: 48,
                child: IconButton(
                  onPressed: () {},
                  highlightColor: Colors.grey.shade400,
                  icon: const Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextField(
                onTap: () async {},
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
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                onTap: () async {
                  await animateTo();
                },
                label: 'password',
                hint: 'Enter password',
                obsecure: obsecure,
                passwordIcon: IconButton(
                  onPressed: () {
                    obsecure = !obsecure;
                    setState(() {});
                  },
                  icon: (obsecure)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
