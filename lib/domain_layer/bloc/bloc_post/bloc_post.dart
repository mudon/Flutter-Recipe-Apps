import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/data_layer/helper/post/fetch_post_helper.dart';
import 'package:recipe_project/data_layer/helper/fetch_user_helper.dart';
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

      emit(PostsLoaded(posts));
    });

    on<GetUserSavedPosts>((event, emit) async {
      savedPosts = await FetchUserHelper.savedPosts(uid);
      emit(savedPostsLoaded(savedPosts!));
    });
  }
}
