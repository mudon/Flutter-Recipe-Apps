// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_project/core/style/colors.dart';
import 'package:recipe_project/data_layer/models/list_of_recipe.dart';

class RecipeDetail extends StatefulWidget {
  final RecipeInstance instance;
  const RecipeDetail({super.key, required this.instance});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  late Map<String, List<String>> bahan;
  late Map<String, List<String>> penyediaan;
  late String? laluanGambar;
  late String? name;
  List<Map<String, String>> dummyComments = [
    {"name": "Muhammad Hazim", "timestamp": "12 min", "comment": "sedapnyaa"},
    {"name": "John Doe", "timestamp": "5 min", "comment": "Great post!"},
    {
      "name": "Jane Smith",
      "timestamp": "1 hr",
      "comment": "I agree with this."
    },
  ]; //remember to change
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    name = widget.instance.name;
    bahan = widget.instance.bahan;
    penyediaan = widget.instance.penyediaan;
    laluanGambar = widget.instance.laluanGambar;
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
                IconButton(
                  icon: Icon(Icons.bookmark_border_rounded),
                  onPressed: () {},
                ),
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
                IconButton.filledTonal(
                  icon: Icon(Icons.arrow_upward),
                  color: recipeColor.primary,
                  onPressed: () {
                    dummyComments.add({
                      "name": "maybe",
                      "timestamp": "example",
                      "comment": "comment"
                    });
                    print(dummyComments);
                  },
                ),
              ]),
            ),
            SliverToBoxAdapter(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dummyComments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final comment = dummyComments[index];
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
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
                                          comment["name"]!,
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          comment["timestamps"]!,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      comment["comment"]!,
                                    )
                                  ],
                                )),
                          )
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
