import 'package:bloc/bloc.dart';
import 'package:recipe_project/data_layer/helper/fetch_post_helper.dart';
import 'package:recipe_project/data_layer/helper/recipe_list_to_map.dart';
import 'package:recipe_project/data_layer/models/list_of_recipe.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/repo/posts/fetch_post.dart';
import 'package:recipe_project/domain_layer/bloc/recipe_fetch_event.dart';
import 'package:recipe_project/domain_layer/bloc/recipe_fetch_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  late List<RecipeInstance> allRecipes;
  late List<PostModel> posts;

  RecipeBloc() : super(RecipeInitial()) {
    on<LoadRecipes>((event, emit) async {
      allRecipes = await RecipeListToMap.recipeListMap();
      for (final recipe in allRecipes) {
        recipe.laluanGambar = recipe.namaSamaran;
      }

      emit(RecipeLoaded(allRecipes, allRecipes, false, event.isIndex));
    });

    on<SearchRecipe>((event, emit) {
      final filteredRecipes = event.query.isEmpty
          ? allRecipes
          : allRecipes.where((recipe) {
              return recipe.name
                  .toLowerCase()
                  .contains(event.query.toLowerCase());
            }).toList();

      emit(RecipeLoaded(
          allRecipes, filteredRecipes, event.query.isNotEmpty, event.isIndex));
    });

    on<GetPosts>((event, emit) async {
      posts = await FetchPostHelper.getPosts();

      emit(PostsLoaded(posts));
    });
  }
}
