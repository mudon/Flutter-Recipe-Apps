import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/repo/posts/crud_post.dart';
import 'package:recipe_project/data_layer/services/auth_service.dart';
import 'package:uuid/uuid.dart';

class CrudPostHelper {
  static Future<void> addPostFromBackend() async {
    await CrudPost.addPostFromBackend();
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
          "https://firebasestorage.googleapis.com/v0/b/bahtera-resipi-d733f.appspot.com/o/recipeImg%2F${recipeData["name"].toLowerCase().replaceAll(' ', '-')}.jpg?alt=media&token=963031fd-28c1-417b-aeb8-33c9017dcb03",
      "contentDescription": "dummyContent",
      "timePosted": Timestamp.now(),
      "likes": likesData,
      "comments": commentsData,
    };

    CrudPost.addPost(postData);
  }

  static Future<void> editPost() async {}
  static Future<void> removePost() async {}
}
