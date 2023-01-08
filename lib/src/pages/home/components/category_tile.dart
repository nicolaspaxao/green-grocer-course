// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:quitanda_com_getx/src/config/colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? customSwatchColor : Colors.transparent,
          ),
          child: Text(
            category,
            style: TextStyle(
                color: isSelected ? Colors.white : customConstrastColor,
                fontWeight: FontWeight.bold,
                fontSize: isSelected ? 16 : 14),
          ),
        ),
      ),
    );
  }
}
