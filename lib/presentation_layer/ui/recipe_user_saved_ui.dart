import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/core/style/colors.dart';
import 'package:recipe_project/data_layer/helper/post/fetch_post_helper.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_state.dart';
import 'package:recipe_project/presentation_layer/ui/recipe_detail_ui.dart';

class UserSavedRecipe extends StatefulWidget {
  const UserSavedRecipe({super.key});

  @override
  State<UserSavedRecipe> createState() => _UserSavedRecipeState();
}

class _UserSavedRecipeState extends State<UserSavedRecipe> {
  void dispose() {
    super.dispose();
  }

  Future<List<PostModel>> _fetchBookmarkedPosts(List<String> postIds) async {
    // Fetch posts based on the list of post IDs.
    return await FetchPostHelper.getPostsByIds(postIds);
  }

  @override
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
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              // Collect post IDs from bookmarked posts
              final postIds =
                  userState.user.bookmarkedPosts?.keys.toList() ?? [];

              return FutureBuilder<List<PostModel>>(
                future: _fetchBookmarkedPosts(postIds),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Center(child: Text("Error loading bookmarks"));
                  }

                  final bookmarkedPosts = snapshot.data!;

                  return ListView.builder(
                    itemCount: bookmarkedPosts.length,
                    itemBuilder: (context, index) {
                      final post = bookmarkedPosts[index];

                      return Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetail(instance: post)));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: recipeColor.background,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            height: 200,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(10),
                                    topEnd: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    post.contentImg ?? "",
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Text(
                                    post.contentTitle ?? "",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Center(
                  child: Text("User not logged in or no bookmarks found."));
            }
          },
        ),
      ),
    );
  }
}
