import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  // Shared border builder for all text fields
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: color),
  );

  // 1. Light Theme
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.lightBgColor,
    primaryColor: AppColors.mainLightColor,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.mainLightColor),
      titleTextStyle: AppStyles.headTitleLight,
    ),

    textTheme: TextTheme(
      titleLarge: AppStyles.onboardingTitleLight,
      titleMedium: AppStyles.headTitleLight,
      bodyMedium: AppStyles.onboardingBodyLight,
      bodySmall: AppStyles.sectionTitleLight,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainLightColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: AppStyles.primaryButtonLight,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteColor,
      hintStyle: AppStyles.hintTextLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: _border(AppColors.strokeWhiteColor),
      enabledBorder: _border(AppColors.strokeWhiteColor),
      focusedBorder: _border(AppColors.mainLightColor),
      errorBorder: _border(AppColors.redColor),
      focusedErrorBorder: _border(AppColors.redColor),
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
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF101127),
    primaryColor: AppColors.mainDarkColor,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.mainDarkColor),
      titleTextStyle: AppStyles.headTitleDark,
    ),

    textTheme: TextTheme(
      titleLarge: AppStyles.onboardingTitleLight.copyWith(
        color: AppColors.whiteColor,
      ),
      titleMedium: AppStyles.headTitleDark,
      bodyMedium: AppStyles.onboardingBodyLight.copyWith(
        color: AppColors.whiteColor,
      ),
      bodySmall: AppStyles.sectionTitleLight.copyWith(
        color: AppColors.whiteColor,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainLightColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: AppStyles.primaryButtonDark,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputColor,
      hintStyle: AppStyles.hintTextDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: _border(AppColors.strokeDarkColor),
      enabledBorder: _border(AppColors.strokeDarkColor),
      focusedBorder: _border(AppColors.mainDarkColor),
      errorBorder: _border(AppColors.redColor),
      focusedErrorBorder: _border(AppColors.redColor),
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