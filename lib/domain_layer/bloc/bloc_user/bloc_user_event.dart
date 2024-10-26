import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/models/user.dart';

abstract class UserEvent {}

abstract class SavedPostEvent {}

class LoadUser extends UserEvent {
  LoadUser();
}

class GetUser extends UserEvent {
  GetUser();
}

class AddSavedPosts extends SavedPostEvent {
  UserModel user;
  PostModel postToSave;

  AddSavedPosts(this.user, this.postToSave);
}
