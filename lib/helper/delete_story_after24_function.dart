import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/delete_story_after_24_h.dart';

void deleteStories(List<dynamic> stories, UserModel userModel) {
  DeleteStoryAfter24H().deleteStoryAfter24hours(stories, userModel);
}
