import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/data_layer/helper/user/fetch_user_helper.dart';
import 'package:recipe_project/data_layer/models/user.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_event.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserModel? user;

  UserBloc() : super(UserInitial()) {
    on<GetUser>((event, emit) async {
      user = await FetchUserHelper.getUser();

      emit(UserLoaded(user!));
    });
    on<AddSavedPosts>((event, emit) async {
      print(event.postToSave);
      emit(PostSaved(true));
    });
  }
}
