import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/data_layer/helper/post/crud_post_helper.dart';
import 'package:recipe_project/data_layer/helper/user/fetch_user_helper.dart';
import 'package:recipe_project/data_layer/models/user.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_event.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserModel? user;

  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      user = await FetchUserHelper.getUser();

      emit(UserLoaded(user!));
    });

    on<GetUser>((event, emit) async {
      emit(UserLoaded(user!));
    });
  }
}

class SavedPostBloc extends Bloc<SavedPostEvent, SavedPostState> {
  SavedPostBloc() : super(SavedPostInitial()) {
    on<ToggleBookmarkEvent>((event, emit) async {
      await CrudPostHelper.toggleBookmarked(
          event.isBookmarked, event.post.id, event.user.id, event.time);

      if (event.isBookmarked) {
        event.post.isBookmarked?.remove(event.user.id);
        event.user.bookmarkedPosts?.remove(event.post.id);
      } else {
        event.post.isBookmarked?[event.user.id] = {
          "userId": event.user.id,
          "time": event.time,
        };

        event.user.bookmarkedPosts?[event.post.id] = event.post.id;
      }

      emit(PostSaved());
    });
  }
}
