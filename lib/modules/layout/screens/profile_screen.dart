import 'dart:io';

import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_styles.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/layout/widgets/profile_widgets/profile_options_widget.dart';
import 'package:evently/modules/auth/manager/auth_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/app_routes.dart';
import '../widgets/profile_widgets/language_bottom_sheet.dart';
import '../services/profile_services/profile_image_picker_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> pickImage(Future<File?> Function() picker) async {
    final tempImage = await picker();
    if (tempImage == null) return;
    if (!mounted) return;
    setState(() => pickedImage = tempImage);
  }

  void showImageSourceSheet(AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(l10n.profile_galleryProfile),
            onTap: () {
              Navigator.pop(sheetContext);
              pickImage(ProfileImagePickerService.galleryPicker);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt_outlined),
            title: Text(l10n.profile_galleryCamera),
            onTap: () {
              Navigator.pop(sheetContext);
              pickImage(ProfileImagePickerService.cameraPicker);
            },
          ),
        ],
      ),
    );
  }

  Widget buildProfilePhoto(bool isDark) {
    const double size = 100;

    return GestureDetector(
      onTap: () => showImageSourceSheet(AppLocalizations.of(context)!),
      child: Stack(
        children: [
          ClipOval(
            child: pickedImage != null
                ? Image.file(
                    pickedImage!,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/profilePhoto.png',
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            right: 2,
            bottom: 5,
            child: Icon(
              Icons.edit,
              size: 30,
              color: isDark
                  ? AppColors.mainDarkColor
                  : AppColors.mainLightColor,
            ),
          ),
        ],
      ),
    );
  }

  bool isOn = true;
  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerTheme = Provider.of<AppThemeProvider>(context);
    final isDark = providerTheme.isDark;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 26),
                buildProfilePhoto(isDark),
                SizedBox(height: 16),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? '',
                  style: isDark
                      ? AppStyles.nameProfileDark
                      : AppStyles.nameProfileLight,
                ),
                SizedBox(height: 4),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? '',
                  style: isDark
                      ? AppStyles.emailProfileDark
                      : AppStyles.emailProfileLight,
                ),
                SizedBox(height: 32),
                ProfileOptionsWidget(
                  title: AppLocalizations.of(context)!.profile_darkMode,
                  onTap: () {
                    providerTheme.changeAppTheme(
                      isDark ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeThumbColor: Colors.white,
                      activeTrackColor: AppColors.mainLightColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade300,
                      value: isDark,
                      onChanged: (v) {
                        providerTheme.changeAppTheme(
                          v ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ProfileOptionsWidget(
                  title: AppLocalizations.of(context)!.profile_language,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const LanguageBottomSheet(),
                    );
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: isDark
                        ? AppColors.mainDarkColor
                        : AppColors.mainLightColor,
                  ),
                ),
                SizedBox(height: 16),
                ProfileOptionsWidget(
                  title: AppLocalizations.of(context)!.profile_logout,
                  onTap: () async {
                    await providerAuth.signOut();
                    if (!context.mounted) return;
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.loginScreen,
                    );
                  },
                  trailing: Icon(
                    Icons.logout_outlined,
                    color: AppColors.redColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
