import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/helper/post/fetch_post_helper.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/models/user.dart';
import 'package:recipe_project/data_layer/repo/user/fetch_user.dart';

class FetchUserHelper {
  static Future<UserModel?> getUser() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FetchUser.mapUserData();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data();

        if (userData != null) {
          // Convert createdPosts to a list of Strings if it exists
          if (userData["createdPosts"] != null) {
            userData["createdPosts"] =
                List<String>.from(userData["createdPosts"]);
          }

          return UserModel.fromMap(userData);
        }
      }
    } catch (e) {
      // Handle errors (logging, rethrowing, etc.)
      print('Error fetching user data: $e');
    }
    return null; // Return null if user does not exist or any error occurs
  }
}
