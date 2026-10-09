import 'package:evently/core/constant/app_category.dart';
import 'package:evently/core/theme/app_styles.dart';
import 'package:evently/modules/edit_event/screens/edit_event_screen.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/models/event_model.dart';
import '../../../core/services/database_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../layout/widgets/appbar_widgets/actions_widget.dart';
import '../../layout/widgets/appbar_widgets/leading_widget.dart';

class DetailsEventScreen extends StatelessWidget {
  final EventModel event;
  const DetailsEventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;
    final theme = Theme.of(context);

    final parsed = DateTime.tryParse(event.date);
    final dateText = parsed == null
        ? event.date
        : DateFormat('d MMMM').format(parsed);

    final borderColor = isDark
        ? AppColors.mainDarkColor
        : AppColors.strokeWhiteColor;
    final boxColor = isDark
        ? AppColors.darkInputColor
        : const Color(0xFFF5F7FF);

    final category = AppCategory.categories.firstWhere(
      (c) => c.id == event.categoryId,
    );
    final headStyle = isDark
        ? AppStyles.headTitleDark
        : AppStyles.headTitleLight;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details', style: headStyle),
        leading: LeadingWidget(),
        actions: [
          ActionsWidget(
            icon: Icons.edit_rounded,
            color: isDark ? AppColors.whiteColor : AppColors.mainLightColor,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EditEventScreen(event: event)),
            ),
          ),
          SizedBox(width: 10),
          ActionsWidget(
            icon: Icons.delete,
            color: Colors.red,
            onTap: () async {
              await DatabaseService.deleteEvent(event.id);
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(category.image),
            ),
            const SizedBox(height: 16),
            Text(
              event.title,
              style: isDark
                  ? AppStyles.headTitleDark
                  : AppStyles.headTitleLight,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkInputColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? AppColors.strokeDarkColor
                            : AppColors.strokeWhiteColor,
                      ),
                    ),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      size: 28,
                      color: isDark
                          ? AppColors.mainDarkColor
                          : AppColors.mainLightColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateText,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: isDark
                              ? AppColors.mainDarkColor
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        event.time,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: isDark ? Colors.white : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Description', style: headStyle),
            const SizedBox(height: 8),
            SizedBox(
              height: 168,
              child: TextFormField(
                initialValue: event.desc,
                readOnly: true,
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.strokeDarkColor
                          : AppColors.strokeWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
