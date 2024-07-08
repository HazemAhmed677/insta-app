import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/chat_bubble.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/chats/chat_one_to_one_service.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, this.currentUserID, this.recieverUser});
  final String? currentUserID;
  final UserModel? recieverUser;
  static String chatViewID = 'Chat view';
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController textEditingController = TextEditingController();
  String messege = '';
  ScrollController controller = ScrollController();
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
                      width: width * 0.024,
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
              // *********************** ListView
              StreamBuilder<QuerySnapshot>(
                  stream: ChatOneToOneService().fetchAllMesseges(
                      currentUserID: widget.currentUserID!,
                      reciever: widget.recieverUser!),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: (snapshot.hasData)
                          ? ListView.builder(
                              reverse: true,
                              controller: controller,
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                return ChatBubbleFromMe(
                                  messege: snapshot.data!.docs[index]
                                      ['messege'],
                                );
                              })
                          : (snapshot.connectionState ==
                                  ConnectionState.waiting)
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: kPink,
                                  ),
                                )
                              : (snapshot.data == null)
                                  ? const Center(child: Text('No messeges yet'))
                                  : (snapshot.hasError)
                                      ? const Text('error')
                                      : const SizedBox(),
                    );
                  }),
              // *************************
              // *************************
              //TEXT FIELD
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  top: 18,
                ),
                child: TextField(
                  clipBehavior: Clip.none,
                  controller: textEditingController,
                  cursorColor: const Color.fromARGB(255, 0, 140, 255),
                  onSubmitted: (value) async {
                    if (value != '') {
                      messege = value;
                      textEditingController.clear();
                      await ChatOneToOneService().pushMessegeToFireStore(
                          messege: messege,
                          currentUserID: widget.currentUserID!,
                          reciever: widget.recieverUser!);
                      await controller.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    prefixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.image,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        messege = textEditingController.text;
                        textEditingController.clear();
                        await ChatOneToOneService().pushMessegeToFireStore(
                            messege: messege,
                            currentUserID: widget.currentUserID!,
                            reciever: widget.recieverUser!);
                        await controller.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                        setState(() {});
                      },
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
