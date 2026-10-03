import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../providers/app_theme_provider.dart';

class GoogleElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;

  const GoogleElevatedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        backgroundColor: isDark
            ? AppColors.strokeDarkColor
            : AppColors.whiteColor,
        elevation: 0,
          overlayColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark
                ? AppColors.strokeDarkColor
                : AppColors.strokeWhiteColor,
            width: 1,
          ),
        ),
      ),
      onPressed: isLoading ? null : onTap,
      child: Center(
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/GoogleIcon.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 16),
                  Text(
                    title,
                    style: AppStyles.primaryButtonLight.copyWith(
                      color: isDark
                          ? AppColors.mainDarkColor
                          : AppColors.mainLightColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
