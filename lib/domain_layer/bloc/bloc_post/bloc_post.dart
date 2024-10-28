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
      await CrudPostHelper.toggleLikes(
          event.isLiked, event.post.id, event.userId, event.time);

      if (event.isLiked) {
        event.post.likes?.remove(event.userId);
      } else {
        event.post.likes?[event.userId] = {
          "userId": event.userId,
          "icon": 1,
          "time": event.time,
        };
      }

      emit(LikePostsToggled());
    });
  }
}

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<AddComment>((event, emit) async {
      /*
      postId: String.

      commentData:
      {
        time: TimeStamp,
        userId: String,
        comment: String,
        name: String
      }
     */
      Map<String, dynamic> updateCommentData =
          await CrudPostHelper.addComment(event.post.id, event.commentData);

      event.post.comments?.add(updateCommentData);

      emit(Commented(updateCommentData));
    });
  }
}
