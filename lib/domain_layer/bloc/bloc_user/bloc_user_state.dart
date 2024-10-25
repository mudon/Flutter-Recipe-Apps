import 'package:recipe_project/data_layer/models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);
}

class PostSaved extends UserState {
  bool isSaved;
  PostSaved(this.isSaved);
}
