import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String id;
  String authorId;
  Map<String, List<String>> bahan;
  Map<String, List<String>> penyediaan;

  String contentTitle;
  String? contentDescription;
  String contentImg;
  Map<String, Map<String, dynamic>>? likes;
  Timestamp timePosted;
  List<Map<String, dynamic>>? comments;
  PostModel(
      {required this.id,
      required this.authorId,
      required this.bahan,
      required this.penyediaan,
      required this.contentTitle,
      required this.contentImg,
      required this.timePosted,
      this.contentDescription,
      this.likes,
      this.comments});

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map["id"],
      authorId: map["authorId"],
      bahan: (map["bahan"] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, List<String>.from(value as List<dynamic>)),
      ),
      penyediaan: (map["penyediaan"] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, List<String>.from(value as List<dynamic>)),
      ),
      contentTitle: map["contentTitle"],
      contentImg: map["contentImg"],
      contentDescription: map["contentDescription"],
      timePosted: map["timePosted"],
      likes: (map["likes"] != null)
          ? (map["likes"] as Map<dynamic, dynamic>).map(
              (key, value) => MapEntry(
                key as String,
                Map<String, dynamic>.from(value as Map),
              ),
            )
          : {},
      comments: (map["comments"] != null)
          ? List<Map<String, dynamic>>.from(map["comments"] as List<dynamic>)
          : [],
    );
  }
}
