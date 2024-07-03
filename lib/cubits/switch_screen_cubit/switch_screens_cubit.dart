import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screen_cubit_states.dart';

class SwitchScreensCubit extends Cubit<SwitchScreensStates> {
  SwitchScreensCubit() : super(HomeScreenState());
  int currentIndex = 0;
  void getScreen() {
    if (currentIndex == 0) {
      emit(HomeScreenState());
    } else if (currentIndex == 1) {
      emit(SearchScreenState());
    } else if (currentIndex == 2) {
      emit(AddPostScreenState());
    } else {
      emit(ProfilScreenState());
    }
  }
}
