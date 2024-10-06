import 'package:recipe_project/data_layer/models/list_of_recipe.dart';
import 'package:recipe_project/data_layer/repo/recipe_list_repo.dart';

class RecipeListToMap {
  static Future<List<RecipeInstance>> recipeListMap() async {
    List<dynamic> recipeListInJson = await RecipeListRepo.getRecipeList();
    List<RecipeInstance> recipeInstances = recipeListInJson
        .map((recipeJson) => RecipeInstance.fromMap(recipeJson))
        .toList();

    return recipeInstances;
  }
}
