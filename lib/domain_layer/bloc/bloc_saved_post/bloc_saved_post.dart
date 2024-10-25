import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_event.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_state.dart';

class BlocSavedPost extends Bloc<UserEvent, UserState> {
  BlocSavedPost() : super(UserInitial()) {
    on<AddSavedPosts>((event, emit) async {
      print(event.postToSave);
      emit(PostSaved(true));
    });
  }
}
