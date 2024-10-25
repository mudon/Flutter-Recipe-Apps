import 'package:recipe_project/data_layer/models/post.dart';

abstract class BlocSavedEvent {}

class AddSavedPosts extends BlocSavedEvent {
  PostModel postToSave;
  AddSavedPosts(this.postToSave);
}
