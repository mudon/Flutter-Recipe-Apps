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
  String postId;

  AddSavedPosts(this.user, this.postId);
}

class RemoveSavedPost extends SavedPostEvent {
  UserModel user;
  String postId;

  RemoveSavedPost(this.user, this.postId);
}

class ToggleBookmarkEvent extends SavedPostEvent {
  final String postId;

  ToggleBookmarkEvent(this.postId);
}
