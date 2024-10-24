import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';

class CrudImage {
  static Future<void> addImageUser(String imgName, String userUid) async {
    DirectFirebase.storageRef.child("recipeImgs/${userUid}/${imgName}");
  }

  static Future<void> addImagePost(String imgName, String postUid) async {
    DirectFirebase.storageRef.child("recipeImgs/${postUid}/${imgName}");
  }

  static Future<void> editImage() async {}
  static Future<void> removeImage() async {}
}
