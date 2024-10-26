import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/repo/img/crud_image.dart';
import 'package:recipe_project/data_layer/repo/posts/crud_post.dart';
import 'package:recipe_project/data_layer/repo/posts/fetch_post.dart';
import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';
import 'package:recipe_project/data_layer/services/auth_service.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_event.dart';
import 'package:uuid/uuid.dart';

class CrudPostHelper {
  static Future<void> addPostFromBackend() async {
    await CrudPost.addPostFromBackend();
  }

  static Future<void> addPost(dynamic recipeData) async {
    /*
      recipeData >> Object
      {
        name: String, aka* title
        bahan: Map<String, dynamic>,
        penyediaan: Map<String, dynamic>,
        likes: Map<dynamic, dynamic>,
        comments: List<dynamic>,
        contentDescription: String,
        imgName: String{path},
      }
    */
    const uuid = Uuid();
    String postUid = uuid.v4();
    bool imgExist;
    String recipeName;
    String? recipeUrl;

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

    recipeName = recipeData['name'].toLowerCase().replaceAll(' ', '-');
    imgExist =
        await doesImageExist('recipeImgs/developerPostImgs/$recipeName.jpg');

    if (imgExist)
      recipeUrl =
          "https://firebasestorage.googleapis.com/v0/b/bahtera-resipi-d733f.appspot.com/o/recipeImgs%2FdeveloperPostImgs%2F${recipeName}.jpg?alt=media&token=5fe13439-7a55-4215-af79-b222c619d1f0";
    else
      recipeUrl = await CrudImage.addPostImg(recipeData["imgName"], postUid);

    Map<String, dynamic> postData = {
      "id": postUid,
      "authorId": AuthService.user?.uid,
      "bahan": reTypeBahan,
      "penyediaan": reTypePenyediaan,
      "contentTitle": recipeData["name"],
      "contentImg": recipeUrl,
      "contentDescription": "dummyContent",
      "timePosted": Timestamp.now(),
      "likes": likesData,
      "comments": commentsData,
      "isBookmarked": false,
    };

    CrudPost.addPost(postData);
  }

  static Future<void> editPost() async {}
  static Future<void> removePost() async {}

  static Future<bool> doesImageExist(String imagePath) async {
    try {
      await DirectFirebase.storageRef.child(imagePath).getDownloadURL();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> addComment(
      String postId, Map<String, dynamic> commentData) async {
    /*
      postId: String.

      commentData:
      {
        time: TimeStamp,
        userId: String,
        commentId: String,
        comment: String,
        userName: String
      }
     */
    await CrudPost.addComment(postId, commentData);
  }

  static Future<void> removeComments() async {}
  static Future<void> editComments() async {}

  static Future<void> getLikes(String postId) async {
    await CrudPost.getLikes(postId);
  }

  static Future<void> toggleLikes(
      bool isLiked, String postId, String userId, Timestamp time) async {
    if (isLiked)
      CrudPost.removeLikes(postId, userId);
    else
      CrudPost.addLikes(postId, userId, time);
  }

  static Future<void> AddSavedPosts(String? userId, String postId) async {
    await CrudPost.addSavedPost(userId, postId);
  }

  static Future<void> removeSavedPost(String? userId, String postId) async {
    await CrudPost.removeSavedPost(userId, postId);
  }
}
