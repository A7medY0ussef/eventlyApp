import 'package:evently/core/theme/app_styles.dart';
import 'package:evently/modules/add_event/manager/event_manager.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_category.dart';
import '../../../core/models/event_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../layout/widgets/appbar_widgets/leading_widget.dart';
import '../../layout/widgets/home_widgets/tap_widget.dart';

class EditEventScreen extends StatelessWidget {
  final EventModel event;

  const EditEventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppThemeProvider>(context).isDark;
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => EventProvider()..loadFromEvent(event),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Event',
            style: isDark ? AppStyles.headTitleDark : AppStyles.headTitleLight,
          ),
          leading: LeadingWidget(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<EventProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(provider.selectedCategory.image),
                  ),
                  const SizedBox(height: 16),
                  DefaultTabController(
                    initialIndex: provider.index,
                    length: AppCategory.categories.length,
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicator: const BoxDecoration(color: Colors.transparent),
                      isScrollable: true,
                      onTap: (value) {
                        provider.changeIndex(value);
                      },
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.zero,
                      labelPadding: const EdgeInsets.all(8),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        ...AppCategory.categories.map((e) {
                          final categoryIndex = AppCategory.categories.indexOf(
                            e,
                          );
                          return TapWidget(
                            category: e,
                            isSelected: provider.index == categoryIndex,
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Title',
                    style: isDark
                        ? AppStyles.headTitleDark
                        : AppStyles.headTitleLight,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: provider.titleController,
                    decoration: const InputDecoration(hintText: 'Event Title'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description ',
                    style: isDark
                        ? AppStyles.headTitleDark
                        : AppStyles.headTitleLight,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 168,
                    child: TextFormField(
                      controller: provider.descriptionController,
                      expands: true,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                        hintText: 'Event Description....',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.date_range, color: theme.primaryColor),
                      SizedBox(width: 8),
                      Text('Event Date', style: theme.textTheme.titleLarge),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate:
                                provider.selectedDateTime ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          ).then((value) {
                            if (value != null) provider.changeDate(value);
                          });
                        },
                        child: Text(
                          provider.selectedDateTime == null
                              ? 'Choose Date'
                              : DateFormat.yMd().format(
                                  provider.selectedDateTime!,
                                ),
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: theme.primaryColor),
                      SizedBox(width: 8),
                      Text('Event Time', style: theme.textTheme.titleLarge),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime:
                                provider.selectedTime ?? TimeOfDay.now(),
                          ).then((value) {
                            if (value != null) provider.changeTime(value);
                          });
                        },
                        child: Text(
                          provider.selectedTime?.format(context) ?? event.time,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => provider.updateEvent(context, event),
                      child: Center(
                        child: provider.isLoading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Edit Event',
                                style: isDark
                                    ? AppStyles.primaryButtonDark
                                    : AppStyles.primaryButtonLight,
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
