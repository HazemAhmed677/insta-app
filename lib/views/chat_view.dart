import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/chat_bubble.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/chats/chat_one_to_one_service.dart';

class ChatView extends StatefulWidget {
  const ChatView(
      {super.key, required this.currentUserID, required this.recieverUser});
  final String currentUserID;
  final UserModel recieverUser;
  static String chatViewID = 'Chat view';
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController textEditingController = TextEditingController();
  String messege = '';
  ScrollController controller = ScrollController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String roomId = kChatRoomID(
      currentUserID: widget.currentUserID,
      chatedOneID: widget.recieverUser.uid,
    );

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
                              (widget.recieverUser.profileImageURL != null)
                                  ? CachedNetworkImageProvider(
                                      widget.recieverUser.profileImageURL!)
                                  : const AssetImage(kNullImage),
                          radius: 26,
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          widget.recieverUser.username,
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
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(kChats)
                    .doc(roomId)
                    .collection(kMesseges)
                    .orderBy('sent at', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: (snapshot.hasData && snapshot.data!.size != 0)
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            reverse: true,
                            controller: controller,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              return (snapshot.data!.docs[index]['content']
                                          ['userID'] ==
                                      widget.currentUserID)
                                  ? ChatBubbleFromMe(
                                      messege: snapshot.data!.docs[index]
                                          ['content']['messege'],
                                      sentAt: snapshot.data!.docs[index]
                                          ['sent at'],
                                    )
                                  : ChatBubbleFromFriend(
                                      messege: snapshot.data!.docs[index]
                                          ['content']['messege'],
                                      sentAt: snapshot.data!.docs[index]
                                          ['sent at'],
                                    );
                            })
                        : (snapshot.connectionState == ConnectionState.waiting)
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: kPink,
                                ),
                              )
                            : (snapshot.data!.size == 0)
                                ? const Center(
                                    child: Text(
                                      'No messeges yet',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                : (snapshot.hasError)
                                    ? const Center(child: Text('error'))
                                    : const SizedBox(),
                  );
                },
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
                  maxLines: null,

                  controller: textEditingController,
                  cursorColor: const Color.fromARGB(255, 0, 140, 255),
                  onSubmitted: (value) async {
                    if (value != '') {
                      messege = value;
                      textEditingController.clear();
                      await ChatOneToOneService().pushMessegeToFireStore(
                          messege: messege,
                          currentUserID: widget.currentUserID,
                          reciever: widget.recieverUser);
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
                        if (textEditingController.text != '') {
                          messege = textEditingController.text;
                          textEditingController.clear();
                          await ChatOneToOneService().pushMessegeToFireStore(
                              messege: messege,
                              currentUserID: widget.currentUserID,
                              reciever: widget.recieverUser);
                          try {
                            await controller.animateTo(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } catch (e) {
                            print(e.toString());
                          }

                          setState(() {});
                        }
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
                  textInputAction: TextInputAction
                      .newline, // Enables Shift + Enter for new lines
                  onChanged: (text) {
                    // You can add any additional logic here based on user input
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
