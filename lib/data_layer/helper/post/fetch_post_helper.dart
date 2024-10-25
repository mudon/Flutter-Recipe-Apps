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
      Map<String, List<String>> reTypeBahan =
          (postData["bahan"] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, List<String>.from(value as List<dynamic>)),
      );

      Map<String, List<String>> reTypePenyediaan =
          (postData["penyediaan"] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, List<String>.from(value as List<dynamic>)),
      );

      Map<String, Map<String, dynamic>>? likesData = (postData["likes"] != null)
          ? (postData["likes"] as Map<dynamic, dynamic>).map(
              (key, value) => MapEntry(
                key as String,
                Map<String, dynamic>.from(value as Map),
              ),
            )
          : {};

      List<Map<String, dynamic>>? commentsData = (postData["comments"] != null)
          ? List<Map<String, dynamic>>.from(
              postData["comments"] as List<dynamic>)
          : [];

      postData["bahan"] = reTypeBahan;
      postData["penyediaan"] = reTypePenyediaan;
      postData["likes"] = likesData;
      postData["comments"] = commentsData;

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
}
