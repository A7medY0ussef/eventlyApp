import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_styles.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../providers/app_theme_provider.dart';

class AppbarWidget extends StatelessWidget {
  final VoidCallback? tapBack;
  final VoidCallback? tapSkip;
  final bool showBack;
  const AppbarWidget({
    super.key,
    required this.tapBack,
    this.tapSkip,
    required this.showBack,
  });

  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<AppThemeProvider>(context);
    final isDark = providerTheme.isDark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: showBack
              ? InkWell(
                  onTap: tapBack,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkInputColor
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark
                            ? AppColors.strokeDarkColor
                            : AppColors.strokeWhiteColor,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      color: isDark
                          ? AppColors.mainDarkColor
                          : AppColors.mainLightColor,
                    ),
                  ),
                )
              : null,
        ),

        Image.asset(
          isDark
              ? AppAssets.onboardingLogoDarkImage
              : AppAssets.onboardingLogoLightImage,
        ),

        InkWell(
          onTap: tapSkip,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark
                    ? AppColors.strokeDarkColor
                    : AppColors.strokeWhiteColor,
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.onboarding_skip,
              style: isDark ? AppStyles.skipDark : AppStyles.skipLight,
            ),
          ),
        ),
      ],
    );
  }
}
