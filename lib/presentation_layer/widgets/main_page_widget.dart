import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_project/core/style/colors.dart';
import 'package:recipe_project/data_layer/services/auth_service.dart';
import 'package:recipe_project/domain_layer/bloc/recipe_fetch_bloc.dart';
import 'package:recipe_project/domain_layer/bloc/recipe_fetch_event.dart';
import 'package:recipe_project/domain_layer/bloc/recipe_fetch_state.dart';
import 'package:recipe_project/presentation_layer/ui/recipe_detail_ui.dart';
import 'package:recipe_project/presentation_layer/widgets/icon_button_recipe.dart';

class MainpageWidget extends StatefulWidget {
  const MainpageWidget({super.key});

  @override
  State<MainpageWidget> createState() => _MainpageWidgetState();
}

class _MainpageWidgetState extends State<MainpageWidget> {
  @override
  void initState() {
    super.initState();
    // startTimer();
    likeCount = List<int>.filled(20, 0);
    isLiked = List<bool>.filled(20, false);
  }

  void dispose() {
    _timer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  PageController? _pageController;
  int currentPage = 0;
  Timer? _timer;
  List<int> likeCount = [];
  List<bool> isLiked = [];
  List<bool> bookmarkCount = List.filled(20, false);

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController != null && currentPage < 3 - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      if (_pageController != null) {
        _pageController!.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  List<Widget> buildIndicator(int length) {
    final List<Widget> carouselIndicator = [];
    for (int i = 0; i < length; ++i) {
      carouselIndicator.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
              color: i == currentPage
                  ? Colors.grey.shade700
                  : Colors.grey.shade400,
              shape: BoxShape.circle),
        ),
      );
    }

    return carouselIndicator;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Hiii 👋🏻"), Text("Muhammad Hazim")],
                ),
                CircleAvatar()
              ],
            ),
          ),
        ),
        SliverAppBar(
          expandedHeight: 70.0,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 40.0,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Mencari Resepi...',
                          prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: recipeColor.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: recipeColor.primary),
                          ),
                        ),
                        onChanged: (value) {
                          context
                              .read<RecipeBloc>()
                              .add(SearchRecipe(value, false));
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.logout_rounded),
                    onPressed: () {
                      AuthService.logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoading) {
              return SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is RecipeLoaded) {
              if (!state.isSearching && _pageController == null) {
                _pageController = PageController();
              } else if (state.isSearching && _pageController != null) {
                _pageController!.dispose();
                _pageController = null;
              }

              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    if (!state.isSearching)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (value) {
                                    setState(() {
                                      currentPage = value;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 13.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                                  .allRecipes[index]
                                                  .laluanGambar ??
                                              "null"),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.25),
                                            BlendMode.darken,
                                          ),
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Text(
                                            state.allRecipes[index].name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 60,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: buildIndicator(5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            } else {
              return SliverFillRemaining(
                child: Center(child: Text('No recipes found')),
              );
            }
          },
        ),
        BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoaded) {
              return SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 250,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: recipeColor.primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: recipeColor.primary.withOpacity(0.2),
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecipeDetail(
                                        instance:
                                            state.filteredRecipes[index])));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Image.network(
                                  state.filteredRecipes[index].laluanGambar ??
                                      "null",
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7.0),
                                child: Text(state.filteredRecipes[index].name),
                              ),
                              Spacer(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButtonRecipe(
                                            isSelected: isLiked[index],
                                            iconBefore: Icons.favorite_border,
                                            iconAfter: Icons.favorite),
                                        Container(
                                          // margin: EdgeInsets.only(left: 3.0),
                                          child: Text(
                                            '${likeCount[index]}',
                                            style: TextStyle(
                                              fontSize: 23,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButtonRecipe(
                                        isSelected: bookmarkCount[index],
                                        iconBefore: Icons.bookmark_border,
                                        iconAfter: Icons.bookmark)
                                  ]),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: state.filteredRecipes.length,
                  ),
                ),
              );
            } else {
              return SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ],
    );
  }
}