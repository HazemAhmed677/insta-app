import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/views/home_view.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';
import 'package:insta_app/widgets/custom_text_form_field.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode1 = AutovalidateMode.disabled;
  AutovalidateMode autovalidateMode2 = AutovalidateMode.disabled;
  bool flag1 = false, flag2 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: formKey,
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
                    style: TextStyle(
                      fontSize: 44,
                      fontFamily: 'PlaywriteMX',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  autovalidateMode: autovalidateMode1,
                  flag: flag1,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'please enter your email';
                    } else if (!input.contains('@')) {
                      return 'enter a valid email';
                    } else {
                      return null;
                    }
                  },
                  label: 'email',
                  hint: 'Enter email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  onTap: () async {
                    await kAnimateTo(controller);
                  },
                  autovalidateMode: autovalidateMode2,
                  flag: flag2,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'please enter password';
                    } else if (input.length < 8) {
                      return 'enter 8 characters at least';
                    } else {
                      return null;
                    }
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CustomInkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        autovalidateMode1 = AutovalidateMode.disabled;
                        autovalidateMode2 = AutovalidateMode.disabled;
                        Navigator.pushNamed(context, HomeView.homeViewId);
                      }
                      autovalidateMode1 = AutovalidateMode.always;
                      setState(() {});
                      autovalidateMode2 = AutovalidateMode.always;
                      setState(() {});
                    },
                    text: 'Log in',
                  ),
                ),
                const SignUpWord(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
