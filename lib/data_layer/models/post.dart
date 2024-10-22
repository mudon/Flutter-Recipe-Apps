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
        bahan: map["bahan"],
        penyediaan: map["penyediaan"],
        contentTitle: map["contentTitle"],
        contentImg: map["contentImg"],
        contentDescription: map["contentDescription"],
        timePosted: map["timePosted"],
        likes: map["likes"],
        comments: map["comments"]);
  }
}
