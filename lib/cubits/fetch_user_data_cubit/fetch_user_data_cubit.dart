import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_states.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/fetch_user_data_service.dart';

class FetchUserDataCubit extends Cubit<FetchUserDataState> {
  FetchUserDataCubit() : super(FetchUserDataState());
  late UserModel userModel;
  NetworkImage? networkImage;
  Future<UserModel> fetchUserData() async {
    userModel = await FetchUserDataService().fetchUserData();
    networkImage = (userModel.profileImageURL != null)
        ? NetworkImage(userModel.profileImageURL!)
        : null;
    emit(SuccedState());
    return userModel;
  }
}
