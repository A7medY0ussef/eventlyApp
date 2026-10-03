import 'package:evently/core/theme/app_styles.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/onboarding/widgets/elevated_button_widget.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../widgets/selected_widget.dart';

class PersonalizationWidget extends StatelessWidget {
  final VoidCallback onStart;
  const PersonalizationWidget({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    var providerLanguage = Provider.of<AppLanguageProvider>(context);
    var providerTheme = Provider.of<AppThemeProvider>(context);
    bool isDark = providerTheme.isDark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'logo',
                child: Center(
                  child: Image.asset(
                    isDark
                        ? AppAssets.onboardingLogoDarkImage
                        : AppAssets.onboardingLogoLightImage,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Image.asset(
                isDark
                    ? AppAssets.beingCreativeDarkImage
                    : AppAssets.beingCreativeLightImage,
              ),
              const SizedBox(height: 24),

              Text(
                AppLocalizations.of(context)!.onboarding_title,
                style: isDark
                    ? AppStyles.onboardingTitleDark
                    : AppStyles.onboardingTitleLight,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.onboarding_subtitle,
                style: isDark
                    ? AppStyles.onboardingBodyDark
                    : AppStyles.onboardingBodyLight,
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.onboarding_labelLanguage,
                    style: isDark
                        ? AppStyles.sectionTitleDark
                        : AppStyles.sectionTitleLight,
                  ),
                  const Spacer(),
                  SelectedWidget(
                    title: AppLocalizations.of(context)!.onboarding_langEnglish,
                    isSelected: providerLanguage.appLanguage == 'en',
                    onTap: () => providerLanguage.changeLanguage('en'),
                  ),
                  const Gap(10),
                  SelectedWidget(
                    title: AppLocalizations.of(context)!.onboarding_langArabic,
                    isSelected: providerLanguage.appLanguage == 'ar',
                    onTap: () => providerLanguage.changeLanguage('ar'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.onboarding_labelTheme,
                    style: isDark
                        ? AppStyles.sectionTitleDark
                        : AppStyles.sectionTitleLight,
                  ),
                  const Spacer(),
                  SelectedWidget.icon(
                    icon: isDark
                        ? AppAssets.sunDarkImage
                        : AppAssets.sunLightImage,
                    isSelected: providerTheme.isLight,
                    onTap: () {
                      providerTheme.changeAppTheme(ThemeMode.light);
                    },
                  ),
                  const Gap(10),
                  SelectedWidget.icon(
                    icon: isDark
                        ? AppAssets.moonDarkImage
                        : AppAssets.moonLightImage,
                    isSelected: providerTheme.isDark,
                    onTap: () {
                      providerTheme.changeAppTheme(ThemeMode.dark);
                    },
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButtonWidget(
                title: AppLocalizations.of(context)!.onboarding_btnStart,
                onTap: onStart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
