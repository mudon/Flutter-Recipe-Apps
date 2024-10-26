import 'package:flutter/material.dart';

class IconButtonRecipe extends StatefulWidget {
  final bool? isSelected;
  final IconData? iconBefore;
  final IconData? iconAfter;
  final VoidCallback? onPressed;

  const IconButtonRecipe({
    super.key,
    this.isSelected,
    this.iconBefore,
    this.iconAfter,
    this.onPressed,
  });

  @override
  State<IconButtonRecipe> createState() => _IconButtonRecipeState();
}

class _IconButtonRecipeState extends State<IconButtonRecipe> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      isSelected: widget.isSelected,
      icon: Icon(widget.iconBefore),
      selectedIcon: Icon(widget.iconAfter),
      onPressed: widget.onPressed,
    );
  }
}
