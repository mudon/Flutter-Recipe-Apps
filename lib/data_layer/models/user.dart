import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/models/post.dart';

class UserModel {
  String id;
  String avatarImg;
  List<String> createdPosts;
  String email;
  String name;
  List<PostModel>? savedPosts;
  UserModel(
      {required this.id,
      required this.avatarImg,
      required this.email,
      required this.name,
      required this.createdPosts,
      this.savedPosts});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["userId"],
      avatarImg: map["avatarImg"],
      createdPosts: map["createdPosts"],
      email: map["email"],
      name: map["name"],
      savedPosts: (map["savedPosts"] as List<dynamic>?)
          ?.whereType<PostModel>()
          .toList(),
    );
  }
}
