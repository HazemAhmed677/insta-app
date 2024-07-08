import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_comments_cubit/fetch_all_comments_cubit.dart';
import 'package:insta_app/cubits/fetch_all_comments_cubit/fetch_all_comments_state.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/models/comment_model.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/widgets/user_comment.dart';
import 'package:uuid/uuid.dart';

class AddCommentView extends StatefulWidget {
  const AddCommentView({super.key});
  static String addCommentView = 'Add comment screen';
  @override
  State<AddCommentView> createState() => _AddCommentViewState();
}

class _AddCommentViewState extends State<AddCommentView> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PostModel postModel =
        ModalRoute.of(context)!.settings.arguments as PostModel;
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    UserModel userModel =
        BlocProvider.of<FetchUserDataCubit>(context).userModel;
    String generatedCommentId;
    Future<void> addComment(String generatedCommentId) async {
      if (textEditingController.text != '') {
        CommentModel commentModel = CommentModel(
          username: userModel.username,
          imageProfile: userModel.profileImageURL,
          comment: textEditingController.text,
          likes: [],
          commentID: generatedCommentId,
          dataTime: Timestamp.now(),
          uid: userModel.uid,
        );
        textEditingController.clear();
        Map<String, dynamic> commentMap =
            commentModel.convetToMap(commentModel);
        // firestore code
        await FirebaseFirestore.instance
            .collection(kPosts)
            .doc(postModel.postID)
            .collection(kComments)
            .doc(generatedCommentId)
            .set(commentMap);
      }
    }

    return BlocBuilder<FetchAllCommentsCubit, FetchAllCommentsState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: BlocProvider.of<FetchAllCommentsCubit>(context)
                    .fetchAllComments(postModel),
                builder: (context, snapshot) {
                  return Scaffold(
                    backgroundColor: kBlack,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: hight * 0.01,
                          ),
                          Row(
                            children: [
                              IconButton(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 4, bottom: 4),
                                constraints: const BoxConstraints(),
                                style: const ButtonStyle(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              SizedBox(
                                width: width * 0.04,
                              ),
                              const Text(
                                'Comments',
                                style: TextStyle(
                                  color: kWhite,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: hight * 0.02,
                          ),
                          (snapshot.data == null)
                              ? const Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: kPink,
                                    ),
                                  ),
                                )
                              : (snapshot.data!.size == 0)
                                  ? Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: hight * 0.01),
                                        child: const Center(
                                          child: Text(
                                            'No comments yet',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : (snapshot.hasData)
                                      ? Expanded(
                                          child: ListView.builder(
                                          itemCount: snapshot.data!.size,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: hight * 0.009,
                                              ),
                                              child: UserComment(
                                                postID: postModel.postID,
                                                commentQueryDoc:
                                                    snapshot.data!.docs[index],
                                              ),
                                            );
                                          },
                                        ))
                                      : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12.0,
                              top: 18,
                            ),
                            child: TextField(
                              controller: textEditingController,
                              cursorColor: kPink,
                              onSubmitted: (value) async {
                                generatedCommentId = const Uuid().v4();
                                await addComment(generatedCommentId);
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    generatedCommentId = const Uuid().v4();
                                    await addComment(generatedCommentId);
                                  },
                                  icon: const Icon(Icons.send),
                                ),
                                hintText: 'Add comment',
                                suffixIconColor:
                                    const Color.fromARGB(255, 49, 122, 183),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: kWhite,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: kPink,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
