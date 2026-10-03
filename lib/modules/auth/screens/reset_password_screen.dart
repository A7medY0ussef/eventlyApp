import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/modules/onboarding/widgets/elevated_button_widget.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/app_routes.dart';
import '../../../l10n/app_localizations.dart';
import '../manager/auth_provider.dart';
import '../widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? emailValidator(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validation_emailRequired;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return l10n.validation_emailInvalid;
    }
    return null;
  }

  Widget buildEmailField(AppLocalizations l10n) {
    return CustomTextField(
      controller: emailController,
      hintText: l10n.auth_emailHint,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => emailValidator(value, l10n),
    );
  }

  VoidCallback? buildLoginOnTap(BuildContext context, AuthProvider provider) {
    if (provider.isLoading) return null;

    return () async {
      if (formKey.currentState!.validate()) {
        await provider.resetPassword(
          email: emailController.text,
          context: context,
        );

        if (!context.mounted) return;

        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<AppThemeProvider>(context);
    final isDark = providerTheme.isDark;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.darkInputColor
                                        : AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: isDark
                                          ? AppColors.strokeDarkColor
                                          : AppColors.strokeWhiteColor,
                                    ),
                                  ),
                                  child: Icon(Icons.chevron_left, size: 24),
                                ),
                              ),
                            ),
                            Image.asset(
                              isDark
                                  ? AppAssets.onboardingLogoDarkImage
                                  : AppAssets.onboardingLogoLightImage,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
                      Image.asset(
                        isDark
                            ? AppAssets.resetDarkImage
                            : AppAssets.resetLightImage,
                      ),
                      SizedBox(height: 40),
                      buildEmailField(l10n),
                      const SizedBox(height: 60),
                      ElevatedButtonWidget(
                        title: l10n.auth_resetPassword,
                        onTap: buildLoginOnTap(context, provider),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
