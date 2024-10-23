import 'package:recipe_project/data_layer/repo/recipe_list_repo.dart';
import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';
import 'package:uuid/uuid.dart';

class CrudPost {
  static Future<List<dynamic>?> addPostFromBackend() async {
    const uuid = Uuid();
    List<dynamic> recipeList = await RecipeListRepo.getRecipeList();

    if (recipeList.isNotEmpty) {
      for (dynamic recipe in recipeList) {
        CrudPost.addPost(recipe);
      }
    }
    return null;
  }

  static Future<void> addPost(dynamic recipeData) async {
    print("hiiii $recipeData");
  }

  static Future<void> removePost() async {}
  static Future<void> editPost() async {}
}
