class PostModel {
  final Map<String, dynamic> postLists;
  PostModel({required this.postLists});

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(postLists: map);
  }
}
