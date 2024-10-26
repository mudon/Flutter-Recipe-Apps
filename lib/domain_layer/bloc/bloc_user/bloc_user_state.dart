import 'package:recipe_project/data_layer/models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);
}

abstract class SavedPostState {}

class SavedPostInitial extends SavedPostState {}

class SavedPostLoading extends SavedPostState {}

class PostSaved extends SavedPostState {}

class PostError extends SavedPostState {
  final String message;

  PostError(this.message);
}
