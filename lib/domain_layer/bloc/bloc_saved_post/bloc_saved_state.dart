import 'package:recipe_project/data_layer/models/user.dart';

abstract class BlocSavedState {}

class savedPostInitial extends BlocSavedState {}

class SavedPostLoading extends BlocSavedState {}

class PostSaved extends BlocSavedState {
  bool isSaved;
  PostSaved(this.isSaved);
}
