import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  // 1. Light Theme
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBgColor,
    primaryColor: AppColors.mainLightColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.mainLightColor),
    ),

    textTheme: TextTheme(
      titleLarge: AppStyles.onboardingTitleLight,
      bodyMedium: AppStyles.onboardingBodyLight,
      bodySmall: AppStyles.sectionTitleLight,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: AppStyles.optionSelectedLight,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.mainLightColor,
      unselectedItemColor: AppColors.greyColor,
      showUnselectedLabels: true,
      elevation: 0,
      selectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  // 2. Dark Theme
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF101127),
    primaryColor: AppColors.mainLightColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.mainLightColor),
    ),

    textTheme: TextTheme(
      titleLarge: AppStyles.onboardingTitleLight.copyWith(color: AppColors.whiteColor),
      bodyMedium: AppStyles.onboardingBodyLight.copyWith(color: AppColors.whiteColor),
      bodySmall: AppStyles.sectionTitleLight.copyWith(color: AppColors.whiteColor),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: AppStyles.optionSelectedLight,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.darkInputColor,
      selectedItemColor: AppColors.mainDarkColor,
      unselectedItemColor: AppColors.whiteColor,
      showUnselectedLabels: true,
      elevation: 0,
      selectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}