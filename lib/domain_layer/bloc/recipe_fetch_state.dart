import 'package:recipe_project/data_layer/models/recipe.dart';

abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<Recipe> allRecipes;
  final List<Recipe> filteredRecipes;
  final bool isSearching;
  bool? isIndex;
  RecipeLoaded(
      this.allRecipes, this.filteredRecipes, this.isSearching, this.isIndex);
}
