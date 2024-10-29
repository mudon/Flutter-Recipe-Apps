import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/models/post.dart';

class UserModel {
  String id;
  String avatarImg;
  List<String> createdPosts;
  String email;
  String name;
  Map<String, String>? bookmarkedPosts;

  UserModel(
      {required this.id,
      required this.avatarImg,
      required this.email,
      required this.name,
      required this.createdPosts,
      this.bookmarkedPosts});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["userId"],
      avatarImg: map["avatarImg"],
      createdPosts: List<String>.from(map["createdPosts"]),
      email: map["email"],
      name: map["name"],
      bookmarkedPosts: (map["bookmarkedPosts"] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as String),
      ),
    );
  }
}
