import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../providers/app_theme_provider.dart';

class LeadingWidget extends StatelessWidget {
  const LeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
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
            child: Icon(
              Icons.chevron_left,
              size: 24,
              color: isDark
                  ? AppColors.whiteColor
                  : AppColors.mainLightColor,
            ),
          ),
        ),
      ),
    );
  }
}
