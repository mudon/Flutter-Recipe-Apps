import 'package:cloud_firestore/cloud_firestore.dart';

class PostsRepo {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>?> getPosts() async {
    try {
      Map<String, dynamic>? postsData;
      List<Map<String, dynamic>>? commentsData;
      List<Map<String, dynamic>>? likesData;
      List<Map<String, dynamic>>? PostCommentsLikes = [];

      QuerySnapshot snapshotPosts = await db.collection('posts').get();

      for (QueryDocumentSnapshot docPost in snapshotPosts.docs) {
        postsData = docPost.data() as Map<String, dynamic>;

        commentsData = [];
        likesData = [];

        QuerySnapshot snapshotComments =
            await docPost.reference.collection('comments').get();

        for (QueryDocumentSnapshot docComment in snapshotComments.docs) {
          commentsData.add(docComment.data() as Map<String, dynamic>);
        }

        QuerySnapshot snapshotLikes =
            await docPost.reference.collection('likes').get();

        for (QueryDocumentSnapshot docLike in snapshotLikes.docs) {
          likesData.add(docLike.data() as Map<String, dynamic>);
        }

        PostCommentsLikes.add(
            {"post": postsData, "comments": commentsData, "likes": likesData});
      }
      return PostCommentsLikes;
    } catch (e) {
      print("Error: $e");
    }
  }
}
