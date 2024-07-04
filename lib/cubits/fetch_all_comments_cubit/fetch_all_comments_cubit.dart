import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_comments_cubit/fetch_all_comments_state.dart';
import 'package:insta_app/models/post_model.dart';

class FetchAllCommentsCubit extends Cubit<FetchAllCommentsState> {
  FetchAllCommentsCubit() : super(FetchAllCommentsState());
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllComments(
      PostModel postModel) async* {
    // code of get comments
    try {
      yield await FirebaseFirestore.instance
          .collection(kPosts)
          .doc(postModel.postID)
          .collection(kComments)
          .orderBy('date time')
          .get();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
