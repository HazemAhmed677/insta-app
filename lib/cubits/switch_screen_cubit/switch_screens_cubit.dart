import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/cubits/switch_screen_cubit/switch_screen_cubit_states.dart';

class SwitchScreensCubit extends Cubit<SwitchScreensStates> {
  SwitchScreensCubit() : super(HomeScreenState());
  int currentIndex = 0;
  getScreen() {
    if (currentIndex == 1) {
      emit(SearchScreenState());
    } else if (currentIndex == 2) {
      emit(AddPostScreenState());
    } else if (currentIndex == 3) {
      emit(ProfilScreenState());
    } else {
      emit(HomeScreenState());
    }
  }
}
