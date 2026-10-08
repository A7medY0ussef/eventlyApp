import 'package:evently/core/constant/app_category.dart';
import 'package:flutter/material.dart';

class TapWidget extends StatelessWidget {
  bool isSelected;
  AppCategory category;
  TapWidget({super.key, required this.isSelected, required this.category});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(category.iconData),
            SizedBox(width: 8),
            Text(category.name),
          ],
        ),
      ),
    );
  }
}
