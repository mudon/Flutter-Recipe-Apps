abstract class RecipeEvent {}

class LoadRecipes extends RecipeEvent {
  bool? isIndex;
  LoadRecipes(this.isIndex);
}

class SearchRecipe extends RecipeEvent {
  final String query;
  bool? isIndex;
  SearchRecipe(this.query, this.isIndex);
}

class GetPosts extends RecipeEvent {
  GetPosts();
}
