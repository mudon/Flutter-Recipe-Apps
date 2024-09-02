import 'dart:convert';

import 'package:http/http.dart' as http;

class RecipeListRepo {
  static const urlApi = "http://10.0.2.2:3000/recipeList";

  static Future<List<dynamic>> getRecipeList() async {
    Uri url = Uri.parse(urlApi);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception("Failed to retrieved");
    }
  }
}
