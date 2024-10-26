import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/data_layer/helper/post/crud_post_helper.dart';
import 'package:recipe_project/data_layer/helper/post/fetch_post_helper.dart';
import 'package:recipe_project/data_layer/helper/user/fetch_user_helper.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_post/bloc_post_event.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_post/bloc_post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  late List<PostModel> posts;
  late List<PostModel?> savedPosts;
  late String uid;

  PostBloc() : super(PostInitial()) {
    on<GetPosts>((event, emit) async {
      posts = await FetchPostHelper.getPosts();

      emit(PostsLoaded(posts, false, posts, event.isIndex));
    });

    on<SearchPost>((event, emit) {
      final filteredPost = event.query.isEmpty
          ? posts
          : posts.where((post) {
              return post.contentTitle
                  .toLowerCase()
                  .contains(event.query.toLowerCase());
            }).toList();

      emit(PostsLoaded(
          posts, event.query.isNotEmpty, filteredPost, event.isIndex));
    });
  }
}

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  LikePostBloc() : super(LikePostInitial()) {
    on<ToggleLike>((event, emit) async {
      CrudPostHelper.toggleLikes(
          event.isLiked, event.postId, event.userId, event.time);
      emit(LikePostsToggled());
    });
  }
}
