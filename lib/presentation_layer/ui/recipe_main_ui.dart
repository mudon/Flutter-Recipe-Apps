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
import 'package:recipe_project/presentation_layer/ui/recipe_user_saved_ui.dart';
import 'package:recipe_project/presentation_layer/widgets/main_page_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeBloc()..add(LoadRecipes(false)),
      child: MainPageView(),
    );
  }
}

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> navigationPage = [
    const MainpageWidget(),
    const userSavedRecipe()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationPage[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Business',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: recipeColor.primary,
        onTap: onItemTapped,
      ),
    );
  }
}
