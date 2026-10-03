import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../providers/app_theme_provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon; // زرار العين لحقل الباسورد
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: isDark
          ? AppStyles.optionTextDark
          : AppStyles.optionUnselectedLight,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: isDark
            ? AppStyles.optionTextDark.copyWith(color: AppColors.whiteDarkColor)
            : AppStyles.optionUnselectedLight.copyWith(
                color: AppColors.greyColor,
              ),
        prefixIcon: Icon(prefixIcon, color: AppColors.lightGreyColor),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: isDark ? AppColors.darkInputColor : AppColors.whiteColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark
                ? AppColors.strokeDarkColor
                : AppColors.strokeWhiteColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark
                ? AppColors.strokeDarkColor
                : AppColors.strokeWhiteColor,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.mainLightColor, width: 1.5),
        ),

        errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
      ),
    );
  }
}
