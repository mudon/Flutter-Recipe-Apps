import 'package:recipe_project/data_layer/models/post.dart';

abstract class UserEvent {}

class GetUser extends UserEvent {
  GetUser();
}

class AddSavedPosts extends UserEvent {
  PostModel postToSave;
  AddSavedPosts(this.postToSave);
}
