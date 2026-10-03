import 'package:animate_do/animate_do.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTheme = Provider.of<AppThemeProvider>(context);

    bool isDark = providerTheme.isDark;
    return Scaffold(
      backgroundColor: AppColors.lightBgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ZoomIn(
                duration: const Duration(seconds: 2),
                child: Hero(
                  tag: 'logo',
                  child: isDark
                      ? Image.asset(AppAssets.appLogoDarkImage)
                      : Image.asset(AppAssets.appLogoLightImage),
                ),
              ),
            ),
            BounceInUp(
              delay: const Duration(seconds: 2),
              onFinish: (direction) {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.onboardingScreen,
                );
              },
              child: isDark
                  ? Image.asset(
                      AppAssets.routeLogoDarkImage,
                      width: 214,
                      height: 57,
                    )
                  : Image.asset(
                      AppAssets.routeLogoLightImage,
                      width: 214,
                      height: 57,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
