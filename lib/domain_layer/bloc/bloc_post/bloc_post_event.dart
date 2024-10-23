abstract class PostEvent {}

class GetPosts extends PostEvent {
  GetPosts();
}

class GetUserSavedPosts extends PostEvent {
  String uid;
  GetUserSavedPosts(this.uid);
}
