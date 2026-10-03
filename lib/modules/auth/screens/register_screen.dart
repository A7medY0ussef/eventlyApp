import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_styles.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/auth/manager/auth_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../onboarding/widgets/elevated_button_widget.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/google_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? nameValidator(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validation_nameRequired;
    }
    if (value.trim().length < 3) {
      return l10n.validation_nameTooShort;
    }
    return null;
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

  String? confirmPasswordValidator(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.validation_confirmPasswordRequired;
    }
    if (value != passwordController.text) {
      return l10n.validation_passwordsDoNotMatch;
    }
    return null;
  }

  VoidCallback? buildSignUpOnTap(BuildContext context, AuthProvider provider) {
    if (provider.isLoading) return null;

    return () async {
      if (formKey.currentState!.validate()) {
        await provider.createAccount(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          context: context,
        );

        if (!context.mounted) return;

        if (provider.user != null) {
          Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
        }
      }
    };
  }

  Widget buildHeaderTitle(AppLocalizations l10n, bool isDark) {
    return Text(
      l10n.signup_title,
      style: isDark
          ? AppStyles.headTitleDarkLR.copyWith(color: AppColors.whiteColor)
          : AppStyles.headTitleLightLR,
    );
  }

  Widget buildNameField(AppLocalizations l10n) {
    return CustomTextField(
      controller: nameController,
      hintText: l10n.signup_nameHint,
      prefixIcon: Icons.person_outline,
      keyboardType: TextInputType.name,
      validator: (value) => nameValidator(value, l10n),
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

  Widget buildConfirmPasswordField(AppLocalizations l10n) {
    return CustomTextField(
      controller: confirmPasswordController,
      hintText: l10n.signup_confirmPasswordHint,
      prefixIcon: Icons.lock_outline,
      obscureText: obscureConfirmPassword,
      suffixIcon: IconButton(
        icon: Icon(
          obscureConfirmPassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
        onPressed: () => setState(() {
          obscureConfirmPassword = !obscureConfirmPassword;
        }),
      ),
      validator: (value) => confirmPasswordValidator(value, l10n),
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
          l10n.signup_haveAccountText,
          style: isDark
              ? AppStyles.emailProfileDark
              : AppStyles.emailProfileLight,
        ),
        InkWell(
          onTap: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.loginScreen),
          child: Text(
            l10n.signup_loginLink,
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
                      buildNameField(l10n),
                      const SizedBox(height: 16),
                      buildEmailField(l10n),
                      const SizedBox(height: 16),
                      buildPasswordField(l10n),
                      const SizedBox(height: 16),
                      buildConfirmPasswordField(l10n),
                      const SizedBox(height: 47),
                      ElevatedButtonWidget(
                        title: l10n.signup_button,
                        isLoading: provider.isLoading,
                        onTap: buildSignUpOnTap(context, provider),
                      ),
                      const SizedBox(height: 48),
                      buildHaveAccount(context, l10n, isDark),
                      const SizedBox(height: 32),
                      buildDividerWidget(l10n, isDark),
                      const SizedBox(height: 24),
                      GoogleElevatedButton(
                        title: l10n.signup_googleButton,
                        onTap: () async {
                          try {
                            final result = await AuthService().signInWithGoogle();
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
