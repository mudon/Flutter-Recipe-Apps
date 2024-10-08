import 'package:flutter/material.dart';

class IconButtonRecipe extends StatefulWidget {
  final bool isSelected;
  final IconData iconBefore;
  final IconData iconAfter;

  const IconButtonRecipe({
    super.key,
    required this.isSelected,
    required this.iconBefore,
    required this.iconAfter,
  });

  @override
  State<IconButtonRecipe> createState() => _IconButtonRecipeState();
}

class _IconButtonRecipeState extends State<IconButtonRecipe> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget
        .isSelected; // Initialize local state with the passed isBookmark value
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      isSelected: isSelected,
      icon: Icon(widget.iconBefore),
      selectedIcon: Icon(widget.iconAfter),
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
    );
  }
}
