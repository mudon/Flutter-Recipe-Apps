import 'package:recipe_project/data_layer/models/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<PostModel> posts;
  PostsLoaded(this.posts);
}

class savedPostsLoaded extends PostState {
  final List<PostModel?> savedPosts;

  savedPostsLoaded(this.savedPosts);
}
