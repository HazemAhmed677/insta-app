import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:insta_app/cubits/profile_image_cubit/profile_image_cubit_state.dart';
import 'package:insta_app/helper/modal_progress_hud_helper.dart';
import 'package:insta_app/helper/show_snack_bar_function.dart';
import 'package:insta_app/services/upload_user_data.dart';
import 'package:insta_app/views/home_view.dart';
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
  String? username, email, password;
  File? selectedImage;
  String? imageURL;
  bool isLoading = false;
  var uuid;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: ModalProgressHudHelper(
        isLoading: isLoading,
        child: BlocProvider(
          create: (context) => ProfileImageCubit(),
          child: BlocBuilder<ProfileImageCubit, InitialProfileImageState>(
            builder: (context, state) {
              return Scaffold(
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
                          height: hight * 0.024,
                        ),
                        CustomStackWidget(
                          email: email,
                        ),
                        SizedBox(
                          height: hight * 0.028,
                        ),
                        CustomTextFormField(
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'please enter your name';
                            } else if (input.length < 4) {
                              return 'enter 4 char at least';
                            } else {
                              return null;
                            }
                          },
                          onChange: (data) {
                            if (data.length >= 4) {
                              username = data;
                              flag1 = true;
                              setState(() {});
                            } else if (flag1) {
                              setState(() {});
                            }
                          },
                          label: 'username',
                          hint: 'Enter username',
                          autoFocus: true,
                        ),
                        SizedBox(
                          height: hight * 0.020,
                        ),
                        CustomTextFormField(
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'please enter your email';
                            } else if (!input.contains('@')) {
                              return 'enter a valid email';
                            } else {
                              return null;
                            }
                          },
                          onChange: (data) {
                            if (data.isNotEmpty && data.contains('@')) {
                              autoValidMode[1] = AutovalidateMode.disabled;
                              flag2 = true;
                              email = data;
                            } else if (flag2) {
                              setState(() {});
                            }
                          },
                          onTap: () async {
                            await kAnimateTo(controller);
                          },
                          label: 'email',
                          hint: 'Enter email',
                        ),
                        SizedBox(
                          height: hight * 0.020,
                        ),
                        CustomTextFormField(
                          onTap: () async {
                            await kAnimateTo(controller);
                          },
                          onChange: (data) {
                            if (data.isNotEmpty && data.length >= 6) {
                              autoValidMode[2] = AutovalidateMode.disabled;
                              flag3 = true;
                              password = data;
                            } else if (flag3) {
                              setState(() {});
                            }
                          },
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'please enter password';
                            } else if (input.length < 8) {
                              return 'enter 6 characters at least';
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
                                : const Icon(
                                    Icons.visibility,
                                    color: kPink,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: hight * 0.020,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomInkWell(
                              color: Colors.blue.withOpacity(0.88),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  isLoading = true;
                                  setState(() {});
                                  // firebase code
                                  try {
                                    await signUp();
                                    //hundled in stack widget
                                    selectedImage =
                                        BlocProvider.of<ProfileImageCubit>(
                                                context)
                                            .selectedImage;
                                    if (selectedImage != null) {
                                      await uploadImageToCloud();
                                    }

                                    await UploadUserData()
                                        .addUserDataInFireStore(
                                      username: username!,
                                      email: email!,
                                      password: password!,
                                      imageURL: imageURL,
                                      followers: [],
                                      following: [],
                                    );

                                    setState(() {
                                      isLoading = false;
                                      Navigator.pushNamed(
                                        context,
                                        HomeView.homeViewId,
                                      );
                                    });
                                    formKey.currentState!.reset();
                                    // firestore code
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'email-already-in-use') {
                                      isLoading = false;
                                      setState(() {});
                                      getShowSnackBar(
                                          context, 'Email already exists');
                                    } else {
                                      isLoading = false;
                                      setState(() {});
                                      getShowSnackBar(
                                          context, 'email not valid');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }

                                  for (int i = 0; i < 3; i++) {
                                    autoValidMode[i] =
                                        AutovalidateMode.disabled;
                                  }
                                }
                                for (int i = 0; i < 3; i++) {
                                  autoValidMode[i] = AutovalidateMode.always;
                                  setState(() {
                                    isLoading = false;
                                  });
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
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> uploadImageToCloud() async {
    uuid = FirebaseAuth.instance.currentUser!.uid;
    var reff = FirebaseStorage.instance.ref().child('images').child(uuid);
    await reff.putFile(selectedImage!);
    imageURL = await reff.getDownloadURL();
  }

  Future<void> signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
