import 'package:evently/core/constant/app_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../providers/app_theme_provider.dart';

class CardWidget extends StatelessWidget {
  EventModel event;
  Function onTapFav;

  CardWidget({super.key, required this.event, required this.onTapFav});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;
    var category = AppCategory.categories.firstWhere((element) {
      return element.id == event.categoryId;
    });
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.strokeDarkColor
              : AppColors.strokeWhiteColor,
        ),
        image: DecorationImage(
          image: AssetImage(category.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark
                    ? AppColors.strokeDarkColor
                    : AppColors.strokeWhiteColor,
              ),
            ),
            child: Text(
              event.time,
              style: isDark
                  ? AppStyles.dateOfCardHomeDark
                  : AppStyles.dateOfCardHomeLight,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark
                    ? AppColors.strokeDarkColor
                    : AppColors.strokeWhiteColor,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: isDark
                        ? AppStyles.homeLargeTitleCardDark
                        : AppStyles.homeLargeTitleCardLight,
                  ),
                ),
                InkWell(
                  onTap: () {
                    onTapFav();
                  },
                  child: Icon(
                    event.usersFav.contains(
                          FirebaseAuth.instance.currentUser!.uid,
                        )
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    color: isDark
                        ? AppColors.mainDarkColor
                        : AppColors.mainLightColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
