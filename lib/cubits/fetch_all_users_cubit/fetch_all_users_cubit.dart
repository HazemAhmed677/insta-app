import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_states.dart';
import 'package:insta_app/services/fetch_searched_users.dart';

class FetchSearchedUsersCubit extends Cubit<FetchSearchedUsersStates> {
  FetchSearchedUsersCubit() : super(InitialState());

  Future<QuerySnapshot<Map<String, dynamic>>> fetchSearchedUsers(
      String input) async {
    return await FetchSearchedUsers().fetchSearchedUsers(input);
  }
}
