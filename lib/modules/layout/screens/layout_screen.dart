import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/layout/screens/favorite_screen.dart';
import 'package:evently/modules/layout/screens/home_screen.dart';
import 'package:evently/modules/layout/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../providers/app_theme_provider.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;

    final barColor = isDark ? AppColors.darkInputColor : AppColors.whiteColor;
    final selectedColor = isDark
        ? AppColors.mainDarkColor
        : AppColors.mainLightColor;
    final unselectedColor = isDark ? AppColors.whiteColor : AppColors.greyColor;

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) => setState(() => index = value),
          type: BottomNavigationBarType.fixed,
          backgroundColor: barColor,
          elevation: 0,
          selectedItemColor: selectedColor,
          unselectedItemColor: unselectedColor,
          showUnselectedLabels: true,
          items: [
            buildBottomNavItem(
              label: AppLocalizations.of(context)!.nav_home,
              icon: 'assets/icons/home-2.svg',
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            buildBottomNavItem(
              label: AppLocalizations.of(context)!.nav_favorite,
              icon: 'assets/icons/heart.svg',
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            buildBottomNavItem(
              label: AppLocalizations.of(context)!.nav_profile,
              icon: 'assets/icons/user.svg',
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavItem({
    required String label,
    required String icon,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(selectedColor, BlendMode.srcIn),
      ),
    );
  }
}
