import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/helper/fetch_post_helper.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/models/user.dart';
import 'package:recipe_project/data_layer/repo/user/fetch_user.dart';

class FetchUserHelper {
  static Future<UserModel?> getUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FetchUser.mapUserData();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data();
      if (userData != null) {
        return UserModel.fromMap(userData);
      }
    }
    return null;
  }

  static Future<List<PostModel>> savedPosts(String userId) async {
    UserModel? user = await getUser(userId);
    if (user != null &&
        user.savedPosts != null &&
        user.savedPosts!.isNotEmpty) {
      List<PostModel> posts =
          await FetchPostHelper.getPostsByReferences(user.savedPosts!);
      return posts;
    }
    return [];
  }
}
