import 'package:cloud_firestore/cloud_firestore.dart';
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

class ToggleBookmarkEvent extends SavedPostEvent {
  bool isBookmarked;
  PostModel post;
  UserModel user;
  Timestamp time;
  ToggleBookmarkEvent(this.isBookmarked, this.post, this.user, this.time);
}
