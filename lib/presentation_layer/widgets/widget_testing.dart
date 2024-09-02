import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  Map<String, List<String>> recipeIngredients = {
    "Ayam direbus": ["penyetkan ayam", "perap dengan sos"],
    "Bahan": ["bawang putih", "bawang merah"]
  };

  Widget buildIngredientTiles() {
    return Column(
      children: recipeIngredients.entries.map((entry) {
        return ExpansionTile(
          title: Text(entry.key),
          children: entry.value.map((ingredient) {
            return ListTile(
              title: Text(ingredient),
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
              leading: Icon(Icons.arrow_back),
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
                background: Image.asset(
                  "assets/images/makanan/nasi-ayam.jpeg",
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
                    "Nasi Ayam",
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
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
                            child: buildIngredientTiles(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(children: [
                    Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      width: double.infinity,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text("Penyediaan"),
                          children: [
                            ListTile(
                              title: Text("Step 1: Do something"),
                            ),
                            ListTile(
                              title: Text("Step 2: Do something else"),
                            ),
                            // Add more preparation steps here
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
