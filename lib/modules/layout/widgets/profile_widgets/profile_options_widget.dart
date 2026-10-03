import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../providers/app_theme_provider.dart';

//TODO WAIT SESSION TO CHOOSE CORRECT ANSWER ABOUT TRAILING
class ProfileOptionsWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Widget trailing;

  const ProfileOptionsWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<AppThemeProvider>(context);
    final isDark = providerTheme.isDark;

    return Material(
      color: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark
              ? AppColors.strokeDarkColor
              : AppColors.strokeWhiteColor,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: isDark
                    ? AppStyles.titleProfileOptionsDart
                    : AppStyles.titleProfileOptionsLight,
              ),
              SizedBox(height: 20, width: 36, child: trailing),
            ],
          ),
        ),
      ),
    );
  }
}
