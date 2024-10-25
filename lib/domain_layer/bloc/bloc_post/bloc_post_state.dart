import 'package:recipe_project/data_layer/models/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<PostModel> posts;
  final List<PostModel> filteredPosts;
  final bool isSearching;
  bool? isIndex;

  PostsLoaded(this.posts, this.isSearching, this.filteredPosts, this.isIndex);
}
