import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../providers/app_theme_provider.dart';

class ActionsWidget extends StatelessWidget {
  IconData icon;
  Color color;
  VoidCallback onTap;
  ActionsWidget({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: isDark
                    ? AppColors.strokeDarkColor
                    : AppColors.strokeWhiteColor,
              ),
            ),
            child: InkWell(
              onTap: onTap,
              child: Icon(icon, size: 24, color: color),
            ),
          ),
        ),
      ),
    );
  }
}
