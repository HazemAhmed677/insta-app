import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';
import 'package:insta_app/widgets/custom_question_text.dart';
import 'package:insta_app/widgets/custom_text_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static String signUpId = 'Sign up page';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ScrollController controller = ScrollController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool obsecure = true;
  List<AutovalidateMode> autoValidMode =
      List.filled(3, AutovalidateMode.disabled);
  bool flag1 = false, flag2 = false, flag3 = false;

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
                CustomTextFormField(
                  autovalidateMode: autoValidMode[0],
                  flag: flag1,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'please enter your name';
                    } else if (input.length < 4) {
                      return 'enter 4 char at least';
                    } else {
                      return null;
                    }
                  },
                  label: 'username',
                  hint: 'Enter username',
                  autoFocus: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  autovalidateMode: autoValidMode[1],
                  flag: flag2,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'please enter your email';
                    } else if (!input.contains('@')) {
                      return 'enter a valid email';
                    } else {
                      return null;
                    }
                  },
                  onTap: () async {
                    await kAnimateTo(controller);
                  },
                  label: 'email',
                  hint: 'Enter email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  autovalidateMode: autoValidMode[2],
                  flag: flag3,
                  onTap: () async {
                    await kAnimateTo(controller);
                  },
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
                      color: Colors.blue.withOpacity(0.88),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          for (int i = 0; i < 3; i++) {
                            autoValidMode[i] = AutovalidateMode.disabled;
                          }
                        }
                        for (int i = 0; i < 3; i++) {
                          autoValidMode[i] = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                      text: 'Sign up'),
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
      ),
    );
  }
}
