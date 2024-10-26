import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PostEvent {}

class GetPosts extends PostEvent {
  bool? isIndex;

  GetPosts(this.isIndex);
}

class SearchPost extends PostEvent {
  final String query;
  bool? isIndex;

  SearchPost(this.query, this.isIndex);
}

abstract class LikePostEvent {}

class ToggleLike extends LikePostEvent {
  bool isLiked;
  String postId;
  String userId;
  Timestamp time;
  ToggleLike(this.isLiked, this.postId, this.userId, this.time);
}
