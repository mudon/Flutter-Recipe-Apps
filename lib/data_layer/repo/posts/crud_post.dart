import 'package:recipe_project/data_layer/helper/post/crud_post_helper.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/repo/recipe_list_repo.dart';
import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';

class CrudPost {
  static Future<void> addPostFromBackend() async {
    List<dynamic> recipeList = await RecipeListRepo.getRecipeList();

    if (recipeList.isNotEmpty) {
      for (dynamic recipe in recipeList) {
        CrudPostHelper.addPost(recipe);
      }
    }
  }

  static Future<void> addPost(Map<String, dynamic> postData) async {
    await DirectFirebase.firestoreDatabase
        .collection("posts")
        .doc(postData["id"])
        .set(postData);

    PostModel.fromMap(postData);
  }

  static Future<void> removePost() async {}
  static Future<void> editPost() async {}

  static Future<void> addComment(
      String postId, Map<String, dynamic> commentData) async {
    await DirectFirebase.firestoreDatabase
        .collection("posts")
        .doc(postId)
        .set(commentData);
  }

  static Future<void> removeComment() async {}
  static Future<void> editComment() async {}

  static Future<void> getLikes() async {}
  static Future<void> addLikes() async {}
  static Future<void> removeLikes() async {}
}
