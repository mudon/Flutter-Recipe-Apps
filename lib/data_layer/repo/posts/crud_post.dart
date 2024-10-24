import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
        CrudPost.addPost(recipe);
      }
    }
  }

  static Future<void> addPost(dynamic recipeData) async {
    const uuid = Uuid();
    String postUid = uuid.v4();

    Map<String, List<String>> reTypeBahan =
        (recipeData["bahan"] as Map<String, dynamic>).map(
      (key, value) => MapEntry(key, List<String>.from(value as List<dynamic>)),
    );

    Map<String, List<String>> reTypePenyediaan =
        (recipeData["penyediaan"] as Map<String, dynamic>).map(
      (key, value) => MapEntry(key, List<String>.from(value as List<dynamic>)),
    );

    Map<String, Map<String, dynamic>>? likesData = (recipeData["likes"] != null)
        ? (recipeData["likes"] as Map<dynamic, dynamic>).map(
            (key, value) => MapEntry(
              key as String,
              Map<String, dynamic>.from(value as Map),
            ),
          )
        : {};

    List<Map<String, dynamic>>? commentsData = (recipeData["comments"] != null)
        ? List<Map<String, dynamic>>.from(
            recipeData["comments"] as List<dynamic>)
        : [];

    Map<String, dynamic> postData = {
      "id": postUid,
      "authorId": AuthService.user?.uid,
      "bahan": reTypeBahan,
      "penyediaan": reTypePenyediaan,
      "contentTitle": recipeData["name"],
      "contentImg":
          "https://firebasestorage.googleapis.com/v0/b/bahtera-resipi-d733f.appspot.com/o/recipeImg%2Fnasi-ayam.jpg?alt=media&token=963031fd-28c1-417b-aeb8-33c9017dcb03",
      "contentDescription": "dummyContent",
      "timePosted": Timestamp.now(),
      "likes": likesData,
      "comments": commentsData,
    };

    await DirectFirebase.firestoreDatabase
        .collection("posts")
        .doc(postUid)
        .set(postData);

    await PostModel.fromMap(postData);
  }

  static Future<void> removePost() async {}
  static Future<void> editPost() async {}
}
