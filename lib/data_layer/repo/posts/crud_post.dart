import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_project/data_layer/helper/post/crud_post_helper.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/repo/recipe_list_repo.dart';
import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';
import 'package:recipe_project/data_layer/services/auth_service.dart';
import 'package:uuid/uuid.dart';

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
}
