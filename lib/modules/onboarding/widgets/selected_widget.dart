import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../providers/app_theme_provider.dart';

class SelectedWidget extends StatelessWidget {
  final bool isSelected;
  final String? title;
  final String? icon;
  final VoidCallback onTap;

  const SelectedWidget({
    super.key,
    this.isSelected = true,
    required this.title,
    required this.onTap,
  }) : icon = null;

  const SelectedWidget.icon({
    super.key,
    this.isSelected = true,
    required this.icon,
    required this.onTap,
  }) : title = null;

  Color _backgroundColor(bool isDark) {
    if (isSelected) {
      return isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    }

    return isDark ? AppColors.darkInputColor : AppColors.whiteColor;
  }

  Color _iconColor(bool isDark) {
    if (isSelected) {
      return AppColors.whiteColor;
    }

    return isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
  }

  TextStyle _textStyle(bool isDark) {
    if (isSelected) {
      if (isDark) {
        return AppStyles.optionSelectedLight.copyWith(
          color: AppColors.whiteColor,
        );
      }

      return AppStyles.optionSelectedLight;
    }

    if (isDark) {
      return AppStyles.optionUnselectedLight.copyWith(
        color: AppColors.whiteDarkColor,
      );
    }

    return AppStyles.optionUnselectedLight;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: _backgroundColor(isDark),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: icon != null
              ? ImageIcon(
                  AssetImage(icon!),
                  size: 20,
                  color: _iconColor(isDark),
                )
              : Text(title!, style: _textStyle(isDark)),
        ),
      ),
    );
  }
}
