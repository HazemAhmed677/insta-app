import 'package:flutter/material.dart';
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
  bool obsecure = true;
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
                height: 0.25 * MediaQuery.of(context).size.height,
              ),
              const Center(
                child: Text(
                  'Insta',
                  style: TextStyle(fontSize: 40, fontFamily: 'PlaywriteMX'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const CustomTextField(
                label: 'email',
                hint: 'Enter email',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
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
