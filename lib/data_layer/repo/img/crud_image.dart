import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';

class CrudImage {
  static Future<String> addUserImg(String imgName, String userUid) async {
    DirectFirebase.storageRef.child("avatarImgs/${userUid}/${imgName}.jpg");

    return "https://firebasestorage.googleapis.com/v0/b/bahtera-resipi-d733f.appspot.com/o/recipeImgs%2FuserPostImgs%2F${imgName}.jpg?alt=media&token=5af179e2-e287-4c08-bdda-8a2c4ad06fee";
  }

  static Future<String> addPostImg(String imgName, String postUid) async {
    DirectFirebase.storageRef
        .child("recipeImgs/userPostImgs/${postUid}/${imgName}.jpg");

    return "https://firebasestorage.googleapis.com/v0/b/bahtera-resipi-d733f.appspot.com/o/recipeImgs%2FdeveloperPostImgs%2F${imgName}.jpg?alt=media&token=5fe13439-7a55-4215-af79-b222c619d1f0";
  }

  static Future<void> editImage() async {}
  static Future<void> removeImage() async {}
}
