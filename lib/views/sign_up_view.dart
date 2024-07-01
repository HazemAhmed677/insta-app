import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';
import 'package:insta_app/widgets/custom_question_text.dart';
import 'package:insta_app/widgets/custom_stack_widget.dart';
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

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
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
                  height: 0.125 * hight,
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
                SizedBox(
                  height: hight * 0.025,
                ),
                const CustomStackWidget(),
                SizedBox(
                  height: hight * 0.025,
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
                SizedBox(
                  height: hight * 0.022,
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
                SizedBox(
                  height: hight * 0.022,
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
                SizedBox(
                  height: hight * 0.024,
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
