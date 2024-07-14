import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/modal_progress_hud_helper.dart';
import 'package:insta_app/helper/show_snack_bar_function.dart';
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
  AutovalidateMode autoValidateMode3 = AutovalidateMode.disabled;
  bool flag1 = false, flag2 = false;
  String? email, password;
  bool isLoading = false;
  TextEditingController textEditing1 = TextEditingController(),
      textEditing2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: ModalProgressHudHelper(
        isLoading: isLoading,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              autovalidateMode: autoValidateMode3,
              key: formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                controller: controller,
                children: [
                  SizedBox(
                    height: 0.25 * hight,
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
                  SizedBox(
                    height: hight * 0.017,
                  ),
                  CustomTextFormField(
                    autovalidateMode: autoValidateMode3,
                    validator: (input) {
                      if (input == '') {
                        return 'please enter your email';
                      } else {
                        return null;
                      }
                    },
                    textEditingController: textEditing1,
                    onChange: (data) {
                      if (data != '') {
                        autoValidateMode3 = AutovalidateMode.always;
                        flag1 = true;
                        email = data;
                      } else if (flag1) {
                        autoValidateMode3 = AutovalidateMode.disabled;
                        setState(() {});
                      }
                    },
                    label: 'email',
                    hint: 'Enter email',
                  ),
                  SizedBox(
                    height: hight * 0.022,
                  ),
                  CustomTextFormField(
                    onTap: () async {
                      await kAnimateTo(controller);
                    },
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'please enter password';
                      } else {
                        return null;
                      }
                    },
                    textEditingController: textEditing2,
                    onChange: (data) {
                      if (data != '') {
                        autoValidateMode3 = AutovalidateMode.always;
                        flag2 = true;
                        password = data;
                      } else if (flag2) {
                        autoValidateMode3 = AutovalidateMode.disabled;
                        setState(() {});
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
                          : const Icon(
                              Icons.visibility,
                              color: kPink,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: hight * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CustomInkWell(
                        text: 'Log in',
                        color: Colors.blue.withOpacity(0.88),
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            // firebase auth code
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              await signIn();
                              setState(() {
                                isLoading = false;
                              });
                              formKey.currentState!.reset();
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                isLoading = false;
                                setState(() {});
                                getShowSnackBar(context, 'No account found');
                              } else if (e.code == 'wrong-password') {
                                isLoading = false;
                                setState(() {});
                                getShowSnackBar(context, 'Wrong password');
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                getShowSnackBar(context, e.toString());
                              }
                            } catch (e) {
                              // isLoading = false;
                              // setState(() {});
                              getShowSnackBar(
                                context,
                                e.toString(),
                              );
                            }

                            autoValidateMode3 = AutovalidateMode.disabled;
                          }
                          flag1 = false;
                          flag2 = false;
                          autoValidateMode3 = AutovalidateMode.always;
                        }),
                  ),
                  const SignUpWord(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
