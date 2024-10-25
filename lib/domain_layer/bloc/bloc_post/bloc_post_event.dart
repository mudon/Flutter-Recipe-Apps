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
