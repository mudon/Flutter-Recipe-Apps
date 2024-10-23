import 'package:recipe_project/data_layer/models/recipe.dart';
import 'package:recipe_project/data_layer/repo/recipe_list_repo.dart';

class RecipeListToMap {
  static Future<List<Recipe>> recipeListMap() async {
    List<dynamic> recipeListInJson = await RecipeListRepo.getRecipeList();
    List<Recipe> Recipes = recipeListInJson
        .map((recipeJson) => Recipe.fromMap(recipeJson))
        .toList();

    return Recipes;
  }
}
