// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipe_project/core/style/colors.dart';
import 'package:recipe_project/data_layer/models/post.dart';
import 'package:recipe_project/data_layer/models/user.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_post/bloc_post.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_post/bloc_post_event.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_post/bloc_post_state.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_event.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_state.dart';
import 'package:recipe_project/presentation_layer/widgets/icon_button_recipe.dart';

class RecipeDetail extends StatefulWidget {
  final PostModel instance;
  const RecipeDetail({super.key, required this.instance});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  late Map<String, List<String>> bahan;
  late Map<String, List<String>> penyediaan;
  late String? laluanGambar;
  late String? name;
  late PostModel postInstance;
  late UserModel userInstance;
  TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    postInstance = widget.instance;
    name = postInstance.contentTitle;
    bahan = postInstance.bahan;
    penyediaan = postInstance.penyediaan;
    laluanGambar = postInstance.contentImg;
    comments = List<Map<String, dynamic>>.from(postInstance.comments ?? []);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Widget buildIngredientTiles(Map<String, List<String>> input) {
    return Column(
      children: input.entries.map((entry) {
        return ExpansionTile(
          title: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.arrow_right_sharp),
                ),
                TextSpan(
                  text: entry.key,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          children: entry.value.map((ingredient) {
            return ListTile(
              title: Container(
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.arrow_forward_rounded),
                      ),
                      TextSpan(
                        text: ingredient,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Maklumat"),
              expandedHeight: 400,
              actions: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      UserModel user = userState.user;

                      return BlocBuilder<SavedPostBloc, SavedPostState>(
                        builder: (context, savedPostState) {
                          bool isBookmarked =
                              postInstance.isBookmarked != null &&
                                  postInstance.isBookmarked!
                                      .containsKey(userState.user.id);
                          return IconButtonRecipe(
                            iconBefore: isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            onPressed: () {
                              context.read<SavedPostBloc>().add(
                                  ToggleBookmarkEvent(
                                      isBookmarked,
                                      postInstance,
                                      userState.user,
                                      Timestamp.now()));
                            },
                          );
                        },
                      );
                    }
                    return Container();
                  },
                )
              ],
              backgroundColor: Colors.amber,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  laluanGambar ?? "null",
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70)),
                    color: Colors.white,
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Column(children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 80,
                      height: 4,
                      color: Colors.grey,
                    ),
                  ]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "$name",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: double.infinity,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text("Bahan-Bahan"),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: buildIngredientTiles(bahan),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: double.infinity,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text("Penyediaan"),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: buildIngredientTiles(penyediaan),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Divider(),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Comment...",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: commentController,
                    ),
                  ),
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      UserModel user = userState.user;

                      return BlocBuilder<CommentBloc, CommentState>(
                        builder: (context, commentState) {
                          return IconButton.filledTonal(
                            icon: Icon(Icons.arrow_upward),
                            color: recipeColor.primary,
                            onPressed: () {
                              if (commentController.text.length != 0) {
                                Map<String, dynamic> newComment = {
                                  "time": Timestamp.now(),
                                  "userId": userState.user.id,
                                  "comment": commentController.text,
                                  "name": userState.user.name
                                };
                                context.read<CommentBloc>().add(
                                      AddComment(
                                        postInstance,
                                        newComment,
                                      ),
                                    );

                                setState(() {
                                  comments.add(newComment);
                                });

                                commentController.clear();
                              }
                            },
                          );
                        },
                      );
                    }
                    return Container();
                  },
                )
              ]),
            ),
            SliverToBoxAdapter(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final comment = comments[index];
                    DateTime dateTime = comment["time"].toDate();
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        comment["name"],
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        DateFormat.yMMMMd('en_US')
                                            .add_jm()
                                            .format(dateTime),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    comment["comment"],
                                  )
                                ],
                              ))
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
