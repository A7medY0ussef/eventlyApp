import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_styles.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/modules/auth/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../onboarding/widgets/elevated_button_widget.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/google_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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

  String? passwordValidator(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.validation_passwordRequired;
    }
    if (value.length < 6) {
      return l10n.validation_passwordTooShort;
    }
    return null;
  }

  VoidCallback? buildLoginOnTap(BuildContext context, AuthProvider provider) {
    if (provider.isLoading) return null;

    return () async {
      if (formKey.currentState!.validate()) {
        await provider.logIn(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );

        if (!context.mounted) return;

        if (provider.user != null) {
          Navigator.pushReplacementNamed(context, AppRoutes.layoutScreen);
        }
      }
    };
  }

  Widget buildHeaderTitle(AppLocalizations l10n, bool isDark) {
    return Text(
      l10n.login_title,
      style: isDark
          ? AppStyles.headTitleDarkLR.copyWith(color: AppColors.whiteColor)
          : AppStyles.headTitleLightLR,
    );
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

  Widget buildPasswordField(AppLocalizations l10n) {
    return CustomTextField(
      controller: passwordController,
      hintText: l10n.auth_passwordHint,
      prefixIcon: Icons.lock_outline,
      obscureText: obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
        onPressed: () => setState(() {
          obscurePassword = !obscurePassword;
        }),
      ),
      validator: (value) => passwordValidator(value, l10n),
    );
  }

  Widget buildForgetPasswordText(AppLocalizations l10n, bool isDark) {
    final color = isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.resetPasswordScreen),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          l10n.login_forgetPassword,
          textAlign: TextAlign.right,
          style: AppStyles.optionSelectedLight.copyWith(
            color: color,
            decoration: TextDecoration.underline,
            decorationColor: color,
          ),
        ),
      ),
    );
  }

  Widget buildHaveAccount(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    final color = isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.login_noAccountText,
          style: isDark
              ? AppStyles.emailProfileDark
              : AppStyles.emailProfileLight,
        ),
        InkWell(
          onTap: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.registerScreen),
          child: Text(
            l10n.login_signupLink,
            style: AppStyles.optionSelectedLight.copyWith(
              color: color,
              decoration: TextDecoration.underline,
              decorationColor: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDividerWidget(AppLocalizations l10n, bool isDark) {
    final dividerColor = isDark
        ? AppColors.strokeDarkColor
        : AppColors.strokeWhiteColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 146, child: Divider(color: dividerColor)),
        const SizedBox(width: 12),
        Text(
          l10n.auth_or,
          style: isDark ? AppStyles.orDark : AppStyles.orLight,
        ),
        const SizedBox(width: 12),
        SizedBox(width: 146, child: Divider(color: dividerColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<AppThemeProvider>(context);
    final isDark = providerTheme.isDark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          isDark
              ? AppAssets.onboardingLogoDarkImage
              : AppAssets.onboardingLogoLightImage,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<AuthProvider>(
              builder: (context, provider, child) {
                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      buildHeaderTitle(l10n, isDark),
                      const SizedBox(height: 24),
                      buildEmailField(l10n),
                      const SizedBox(height: 16),
                      buildPasswordField(l10n),
                      const SizedBox(height: 8),
                      buildForgetPasswordText(l10n, isDark),
                      const SizedBox(height: 47),
                      ElevatedButtonWidget(
                        title: l10n.login_button,
                        isLoading: provider.isLoading,
                        onTap: buildLoginOnTap(context, provider),
                      ),
                      const SizedBox(height: 48),
                      buildHaveAccount(context, l10n, isDark),
                      const SizedBox(height: 32),
                      buildDividerWidget(l10n, isDark),
                      const SizedBox(height: 24),
                      GoogleElevatedButton(
                        title: l10n.login_googleButton,
                        onTap: () async {
                          try {
                            final result = await AuthService()
                                .signInWithGoogle();
                            if (result != null && context.mounted) {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.layoutScreen,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
