import 'package:recipe_project/data_layer/repo/recipe_post_repo.dart';
import 'package:recipe_project/data_layer/models/post.dart';

class PostsListToMap {
  static Future<List<PostModel>> postsListMap() async {
    List<Map<String, dynamic>>? postsMap = await PostsRepo.getPosts();
    List<PostModel> postsInstance =
        (postsMap ?? []).map((post) => PostModel.fromMap(post)).toList();

    print(postsInstance[0].postLists);

    return postsInstance;
  }
}
