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
                          Expanded(
                              child: (snapshot.hasData)
                                  ? ListView.builder(
                                      itemCount: snapshot.data!.size,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: hight * 0.009,
                                          ),
                                          child: UserComment(
                                            commentQueryDoc:
                                                snapshot.data!.docs[index],
                                          ),
                                        );
                                      },
                                    )
                                  : const SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12.0,
                              top: 18,
                            ),
                            child: TextField(
                              controller: textEditingController,
                              cursorColor: kPink,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    // store in firebase
                                    if (textEditingController.text != '') {
                                      CommentModel commentModel = CommentModel(
                                        username: userModel.username,
                                        imageProfile: userModel.profileImageURL,
                                        comment: textEditingController.text,
                                        likes: [],
                                        dataTime: Timestamp.now(),
                                      );
                                      Map<String, dynamic> commentMap =
                                          commentModel
                                              .convetToMap(commentModel);
                                      // firestore code
                                      await FirebaseFirestore.instance
                                          .collection(kPosts)
                                          .doc(postModel.postID)
                                          .collection(kComments)
                                          .add(commentMap);
                                      textEditingController.clear();
                                    }
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
