import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/chat_bubble.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/chats/chat_one_to_one_service.dart';

class ChatView extends StatefulWidget {
  ChatView({super.key, this.currentUserID, this.recieverUser});
  final String? currentUserID;
  final UserModel? recieverUser;
  static String chatViewID = 'Chat view';
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController textEditingController = TextEditingController();
  String messege = '';
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
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              (widget.recieverUser!.profileImageURL != null)
                                  ? CachedNetworkImageProvider(
                                      widget.recieverUser!.profileImageURL!)
                                  : null,
                          radius: 26,
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          widget.recieverUser!.username,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: (messege != '')
                        ? ChatOneToOneService().fetchAllMesseges(
                            messege: messege,
                            currentUserID: widget.currentUserID!,
                            reciever: widget.recieverUser!)
                        : null,
                    builder: (context, snapshot) {
                      return (snapshot.hasData)
                          ? ListView.builder(
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                return ChatBubbleFromMe(
                                  messege: snapshot.data!.docs[index]
                                      ['messege'],
                                );
                              })
                          : const Center(
                              child: CircularProgressIndicator(
                              color: kPink,
                            ));
                    }),
              ),
              // *************************
              // *************************
              //TEXT FIELD
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  top: 18,
                ),
                child: TextField(
                  controller: textEditingController,
                  cursorColor: const Color.fromARGB(255, 0, 140, 255),
                  onChanged: (value) {
                    messege = value;
                  },
                  onSubmitted: (value) async {
                    if (value != '') {
                      messege = value;
                      await ChatOneToOneService().pushMessegeToFireStore(
                          messege: value,
                          currentUserID: widget.currentUserID!,
                          reciever: widget.recieverUser!);
                      textEditingController.clear();
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    prefixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.image,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                    ),
                    hintText: 'Messege',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: kWhite,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
