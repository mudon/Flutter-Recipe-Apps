import 'package:cloud_firestore/cloud_firestore.dart';
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
    /*
      postId: String.

      commentData:
      {
        time: TimeStamp,
        userId: String,
        commentId: String,
        comment: String,
        name: String
      }
     */
    DocumentReference commentsRef =
        await DirectFirebase.firestoreDatabase.collection("posts").doc(postId);
    await commentsRef.update({
      'comments': FieldValue.arrayUnion([commentData])
    });
  }

  static Future<void> removeComment() async {}
  static Future<void> editComment() async {}

  static Future<void> getLikes(String postId) async {
    DocumentSnapshot<Map<String, dynamic>> postRef = await DirectFirebase
        .firestoreDatabase
        .collection('posts')
        .doc(postId)
        .get();

    return postRef["likes"];
  }

  static Future<void> addLikes(
      String postId, String userId, Timestamp time) async {
    DocumentReference postRef =
        await DirectFirebase.firestoreDatabase.collection('posts').doc(postId);

    await postRef.set({
      "likes": {
        userId: {
          "userId": userId,
          "icon": 1,
          "time": time,
        }
      }
    }, SetOptions(merge: true));
  }

  static Future<void> removeLikes(String postId, String userId) async {
    DocumentReference postRef =
        await DirectFirebase.firestoreDatabase.collection('posts').doc(postId);

    await postRef.update({"likes.$userId": FieldValue.delete()});
  }

  static Future<void> addBookmark(
      String postId, String? userId, Timestamp time) async {
    DocumentReference userRef =
        DirectFirebase.firestoreDatabase.collection('user').doc(userId);
    DocumentReference postRef =
        DirectFirebase.firestoreDatabase.collection('posts').doc(postId);

    await postRef.set({
      "isBookmarked": {
        userId: {
          "userId": userId,
          "time": time,
        }
      }
    }, SetOptions(merge: true));

    await userRef.update({
      'savedPosts': FieldValue.arrayUnion([postRef])
    });
  }

  static Future<void> removedBookmark(String postId, String? userId) async {
    DocumentReference userRef =
        DirectFirebase.firestoreDatabase.collection('user').doc(userId);
    DocumentReference postRef =
        DirectFirebase.firestoreDatabase.collection('posts').doc(postId);

    await postRef.update({"isBookmarked.$userId": FieldValue.delete()});

    await userRef.update({
      'savedPosts': FieldValue.arrayRemove([postRef])
    });
  }

  static Future<void> addBookmarkModifed(
      String postId, String? userId, Timestamp time) async {
    DocumentReference userRef =
        DirectFirebase.firestoreDatabase.collection('user').doc(userId);
    DocumentReference postRef =
        DirectFirebase.firestoreDatabase.collection('posts').doc(postId);

    // await postRef.set({
    //   "isBookmarked": {
    //     userId: {
    //       "userId": userId,
    //       "time": time,
    //     }
    //   }
    // }, SetOptions(merge: true));

    await userRef.set({
      "bookmarkedPosts": {postId: postId}
    }, SetOptions(merge: true));
  }

  static Future<void> removedBookmarkModified(
      String postId, String? userId) async {
    DocumentReference userRef =
        DirectFirebase.firestoreDatabase.collection('user').doc(userId);
    DocumentReference postRef =
        DirectFirebase.firestoreDatabase.collection('posts').doc(postId);

    // await postRef.update({"isBookmarked.$userId": FieldValue.delete()});

    await userRef.update({
      "bookmarkedPosts.${postId}": FieldValue.delete(),
    });
  }
}
