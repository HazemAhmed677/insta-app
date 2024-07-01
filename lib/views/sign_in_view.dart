import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/show_snack_bar_function.dart';
import 'package:insta_app/views/home_view.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';
import 'package:insta_app/widgets/custom_text_form_field.dart';
import 'package:insta_app/widgets/sign_up_word.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  List<AutovalidateMode> autoValidateMode =
      List.filled(2, AutovalidateMode.disabled);
  bool flag1 = false, flag2 = false;
  String? email, password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: kPink,
        ),
        blur: 1.5,
        color: kBlack,
        opacity: 0.3,
        inAsyncCall: isLoading,
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
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'please enter your email';
                      } else {
                        return null;
                      }
                    },
                    onChange: (data) {
                      if (data.isNotEmpty && data.contains('@')) {
                        autoValidateMode[0] = AutovalidateMode.disabled;
                        flag1 = true;
                        email = data;
                      } else if (flag1) {
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
                    onChange: (data) {
                      if (data.isNotEmpty && data.length >= 6) {
                        autoValidateMode[1] = AutovalidateMode.disabled;
                        flag2 = true;
                        password = data;
                      } else if (flag2) {
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
                            await signInWithGoogle();
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                                Navigator.pushNamed(
                                  context,
                                  HomeView.homeViewId,
                                );
                              });
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                  getShowSnackBar(context, 'No account found');
                                });
                              } else if (e.code == 'wrong-password') {
                                setState(() {
                                  isLoading = false;
                                  getShowSnackBar(context, 'Wrong password');
                                });
                              }
                            }
                          } catch (e) {
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                                getShowSnackBar(
                                  context,
                                  e.toString(),
                                );
                              });
                            }
                          }
                          for (int i = 0; i < 1; i++) {
                            autoValidateMode[i] = AutovalidateMode.disabled;
                          }
                        }
                        flag1 = false;
                        flag2 = false;
                        for (int i = 0; i < 1; i++) {
                          autoValidateMode[i] = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                    ),
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

  Future signInWithGoogle() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
