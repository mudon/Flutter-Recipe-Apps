import 'package:recipe_project/data_layer/repo/posts/crud_post.dart';

class CrudPostHelper {
  static Future<void> addPostFromBackend() async {
    await CrudPost.addPostFromBackend();
  }

  static Future<void> addPost() async {}

  static Future<void> editPost() async {}
  static Future<void> removePost() async {}
}
