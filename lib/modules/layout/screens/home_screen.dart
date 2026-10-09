import 'package:evently/core/constant/app_category.dart';
import 'package:evently/core/models/event_model.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_styles.dart';
import 'package:evently/modules/layout/widgets/home_widgets/card_widget.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/database_service.dart';
import '../../../providers/app_theme_provider.dart';
import '../widgets/home_widgets/tap_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    var provider = Provider.of<AppLanguageProvider>(context);
    final isDark = Provider.of<AppThemeProvider>(context).isDark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back ✨',
                        style: isDark
                            ? AppStyles.homeMediumTitleDark
                            : AppStyles.homeMediumTitleLight,
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.displayName ?? '',
                        style: isDark
                            ? AppStyles.homeLargeTitleDark
                            : AppStyles.homeLargeTitleLight,
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  isDark
                      ? 'assets/icons/moonLight.png'
                      : 'assets/icons/sunLight.png',
                  color: AppColors.mainDarkColor,
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.mainDarkColor
                        : AppColors.mainLightColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    provider.appLanguage.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            DefaultTabController(
              length: AppCategory.categories.length + 1,
              child: TabBar(
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(color: Colors.transparent),
                isScrollable: true,
                onTap: (value) {
                  index = value;
                  setState(() {});
                },
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.all(8),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  TapWidget(
                    isSelected: index == 0,
                    category: AppCategory(
                      id: 'all',
                      name: 'All',
                      image: '',
                      iconData: Icons.menu,
                    ),
                  ),
                  ...AppCategory.categories.map((e) {
                    int categoryIndex = AppCategory.categories.indexOf(e);
                    return TapWidget(
                      category: e,
                      isSelected: index == categoryIndex + 1,
                    );
                  }),
                ],
              ),
            ),
            FutureBuilder(
              future: DatabaseService.getEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  List<EventModel> events = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CardWidget(
                          event: events[index],
                          onTapFav: () async{
                            await DatabaseService.toggleFav(events[index]);
                            setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: events.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
