import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/peson_tile_for_chats.dart';
import 'package:insta_app/models/user_model.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: hight * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      padding:
                          const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(FontAwesomeIcons.arrowLeft),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text(
                      'Chats',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: hight * 0.02,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(kChats)
                        .where('participants',
                            arrayContains:
                                FirebaseAuth.instance.currentUser!.uid)
                        .orderBy('sent at', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        clipBehavior: Clip.none,
                        itemCount: snapshot.data?.size ?? 0,
                        itemBuilder: (context, index) {
                          if (snapshot.hasData) {
                            Map<String, dynamic> snapMap = snapshot
                                .data!.docs[index] as Map<String, dynamic>;
                            List participants = snapMap['participants'];
                            late String friendID;
                            for (int i = 0; i < 2; i++) {
                              if (participants[i] !=
                                  FirebaseAuth.instance.currentUser!.uid) {
                                friendID = participants[i];
                                break;
                              }
                            }

                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(kUsers)
                                    .doc(
                                      friendID,
                                    )
                                    .snapshots(),
                                builder: (context, snapshot2) {
                                  var userMap = snapshot2.data!.data()
                                      as Map<String, dynamic>;
                                  UserModel userModel =
                                      UserModel.fromJson(userMap);

                                  return PersonTileForChats(
                                    profileImage: userModel.profileImageURL,
                                    username: userModel.username,
                                    lastMsg: 'hello',
                                  );
                                });
                          }
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
