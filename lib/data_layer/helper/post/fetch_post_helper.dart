import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/repo/posts/fetch_post.dart';

class FetchPostHelper {
  static Future<List<PostModel>> getPosts() async {
    QuerySnapshot<Map<String, dynamic>> postSnapshot =
        await FetchPost.mapPostData();
    List<PostModel> posts = postSnapshot.docs.map((doc) {
      Map<String, dynamic> postData = doc.data();

      return PostModel.fromMap(postData);
    }).toList();

    return posts;
  }

  static Future<List<PostModel>> getPostsByReferences(
      List<DocumentReference> postReferences) async {
    List<PostModel> posts = [];

    for (DocumentReference ref in postReferences) {
      DocumentSnapshot<Map<String, dynamic>> postSnapshot =
          await ref.get() as DocumentSnapshot<Map<String, dynamic>>;

      if (postSnapshot.exists) {
        Map<String, dynamic>? postData = postSnapshot.data();
        if (postData != null) {
          posts.add(PostModel.fromMap(postData));
        }
      }
    }
    return posts;
  }

  static Future<Map<String, PostModel>> getPostsByReferencesModified(
      List<DocumentReference> postReferences) async {
    Map<String, PostModel> posts = {};

    for (DocumentReference ref in postReferences) {
      DocumentSnapshot<Map<String, dynamic>> postSnapshot =
          await ref.get() as DocumentSnapshot<Map<String, dynamic>>;

      if (postSnapshot.exists) {
        Map<String, dynamic>? postData = postSnapshot.data();
        if (postData != null) {
          posts[postData["id"]] = PostModel.fromMap(postData);
        }
      }
    }
    return posts;
  }
}
