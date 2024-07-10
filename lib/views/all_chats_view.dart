import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/peson_tile_for_chats.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/views/chat_view.dart';
import 'package:insta_app/widgets/custom_all_chat_app_bar.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});
  static String allChatsViewID = 'All chats screen';
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
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
              const CustomAllChatAppBar(),
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
                          late String lastMsg;
                          if (snapshot.hasData) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            List participants = data['participants'];
                            lastMsg = data['content']['messege'];
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
                                if (snapshot2.hasData) {
                                  var userMap = snapshot2.data!.data()
                                      as Map<String, dynamic>;
                                  UserModel userModel =
                                      UserModel.fromJson(userMap);
                                  return SizedBox(
                                    height: hight * 0.1,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Get.to(
                                          ChatView(
                                            currentUserID: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            recieverUser: userModel,
                                          ),
                                          transition: Transition.fade,
                                        );
                                      },
                                      child: PersonTileForChats(
                                        profileImage: userModel.profileImageURL,
                                        username: userModel.username,
                                        lastMsg: lastMsg,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Text('');
                                }
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: kPink,
                              ),
                            );
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
