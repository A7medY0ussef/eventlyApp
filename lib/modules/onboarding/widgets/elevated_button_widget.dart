import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../providers/app_theme_provider.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;

  const ElevatedButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    var providerTheme = Provider.of<AppThemeProvider>(context);

    bool isDark = providerTheme.isDark;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        backgroundColor: isDark
            ? AppColors.mainDarkColor
            : AppColors.mainLightColor,
        elevation: 0,
        overlayColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
      onPressed: isLoading ? null : onTap,
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Text(title, style: AppStyles.primaryButtonLight),
      ),
    );
  }
}
