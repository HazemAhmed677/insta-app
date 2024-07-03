import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/post_widget.dart';
import 'package:insta_app/models/post_model.dart';

class CustomHomeView extends StatefulWidget {
  const CustomHomeView({super.key});

  @override
  State<CustomHomeView> createState() => _CustomHomeViewState();
}

class _CustomHomeViewState extends State<CustomHomeView> {
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(kPosts).snapshots(),
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Insta',
                      style: TextStyle(
                        fontFamily: 'PlaywriteMX',
                        fontSize: 36,
                      ),
                    ),
                    Tooltip(
                      message: 'Log out',
                      showDuration: const Duration(milliseconds: 500),
                      child: IconButton(
                        onPressed: () async {
                          AlertDialog alert = AlertDialog(
                            backgroundColor: Colors.black,
                            shadowColor: Colors.grey.shade800,
                            title: const Text(
                              'Log out of you account?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: kWhite,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  try {
                                    Navigator.pop(context);
                                    await signOut();
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: const Text(
                                  'Log out',
                                  style: TextStyle(
                                    color: kPink,
                                  ),
                                ),
                              ),
                            ],
                          );
                          await showDialog(
                            context: context,
                            builder: (context) => alert,
                          );
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 26,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: hight * 0.18,
                ),
              ),
              SliverList.builder(
                itemCount: snapshot.data?.size ?? 0,
                itemBuilder: (context, index) {
                  return CustomPostWidget(
                    postModel: PostModel.fromJson(snapshot.data!.docs[index]),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
