import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_project/core/style/colors.dart';

import '../../data_layer/services/auth_service.dart';

class userSavedRecipe extends StatefulWidget {
  const userSavedRecipe({super.key});

  @override
  State<userSavedRecipe> createState() => _userSavedRecipeState();
}

class _userSavedRecipeState extends State<userSavedRecipe> {
  @override
  List<Map<String, String>> recipeDetails = [
    {
      "name": "Nasi Ayam",
      "laluanGambar": 'http://10.0.2.2:3000/recipeImage?nasi-ayam.jpeg'
    },
    {
      "name": "Nasi Ayam",
      "laluanGambar": 'http://10.0.2.2:3000/recipeImage?nasi-ayam.jpeg'
    },
    {
      "name": "Nasi Ayam",
      "laluanGambar": 'http://10.0.2.2:3000/recipeImage?nasi-ayam.jpeg'
    },
    {
      "name": "Nasi Ayam",
      "laluanGambar": 'http://10.0.2.2:3000/recipeImage?nasi-ayam.jpeg'
    },
    {
      "name": "Nasi Ayam",
      "laluanGambar": 'http://10.0.2.2:3000/recipeImage?nasi-ayam.jpeg'
    }
  ];
  final User? user = AuthService.user;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: recipeColor.primary,
        title: Text(
          "Bookmarked Recipes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: recipeDetails.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: GestureDetector(
                  onTap: () => {print("zxc $user")},
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: recipeColor.background,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: 200,
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(10),
                            topEnd: Radius.circular(10)),
                        child: Image.network(
                          width: double.infinity,
                          recipeDetails[index]["laluanGambar"] ?? "null",
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Text(
                            recipeDetails[index]["name"]!,
                            style: TextStyle(fontSize: 35, color: Colors.black),
                          ))
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
