import 'package:recipe_project/data_layer/models/list_of_recipe.dart';

abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<RecipeInstance> allRecipes;
  final List<RecipeInstance> filteredRecipes;
  final bool isSearching;
  bool? isIndex;
  RecipeLoaded(this.allRecipes, this.filteredRecipes, this.isSearching, this.isIndex);
}
