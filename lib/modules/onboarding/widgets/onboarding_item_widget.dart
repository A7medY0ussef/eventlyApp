import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_styles.dart';
import '../../../providers/app_theme_provider.dart';

import '../models/onboarding_model.dart';
import 'elevated_button_widget.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingModel item;
  final VoidCallback onTap;
  final String buttonTitle;
  final String title;
  final String subTitle;

  const OnboardingItemWidget({
    super.key,
    required this.item,
    required this.onTap,
    required this.buttonTitle,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<AppThemeProvider>(context);
    final isDark = providerTheme.isDark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(isDark ? item.darkImage : item.lightImage),

            const SizedBox(height: 24),

            Text(
              title,
              style: isDark
                  ? AppStyles.onboardingTitleDark
                  : AppStyles.onboardingTitleLight,
            ),

            const SizedBox(height: 8),

            Text(
              subTitle,
              style: isDark
                  ? AppStyles.onboardingBodyDark
                  : AppStyles.onboardingBodyLight,
            ),

            const Spacer(),

            ElevatedButtonWidget(title: buttonTitle, onTap: onTap),
          ],
        ),
      ),
    );
  }
}
