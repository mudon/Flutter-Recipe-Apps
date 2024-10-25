import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/helper/post/fetch_post_helper.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/models/user.dart';
import 'package:recipe_project/data_layer/repo/user/fetch_user.dart';

class FetchUserHelper {
  static Future<UserModel?> getUser() async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FetchUser.mapUserData();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data();
      List<PostModel> posts;
      if (userData != null) {
        List<String> categoriesList =
            List<String>.from(userData["createdPosts"] as List);

        userData["createdPosts"] = categoriesList;

        List<DocumentReference<Object?>> reTypeSavedPosts =
            (userData["savedPosts"] as List).cast<DocumentReference<Object?>>();

        if (userData["savedPosts"].length != 0) {
          posts = await FetchPostHelper.getPostsByReferences(reTypeSavedPosts);
        } else
          posts = [];

        userData["savedPosts"] = posts;

        return UserModel.fromMap(userData);
      }
    }
    return null;
  }
}
