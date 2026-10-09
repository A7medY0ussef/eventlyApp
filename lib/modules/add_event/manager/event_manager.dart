import 'package:evently/core/constant/app_category.dart';
import 'package:evently/core/models/event_model.dart';
import 'package:flutter/material.dart';

import '../../../core/services/database_service.dart';

class EventProvider extends ChangeNotifier {
  int index = 0;
  AppCategory selectedCategory = AppCategory.categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;
  void changeIndex(int value) {
    index = value;
    selectedCategory = AppCategory.categories[index];
    notifyListeners();
  }

  void changeDate(DateTime date) {
    selectedDateTime = date;
    notifyListeners();
  }

  void changeTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  bool isLoading = false;
  void addEvent(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await DatabaseService.addEvent(
      EventModel(
        id: '',
        title: titleController.text,
        categoryId: selectedCategory.id,
        date: selectedDateTime.toString(),
        desc: descriptionController.text,
        time: selectedTime!.format(context),
      ),
    );
    isLoading = false;
    notifyListeners();
    Navigator.pop(context);
  }

  void loadFromEvent(EventModel event) {
    titleController.text = event.title;
    descriptionController.text = event.desc;
    selectedDateTime = DateTime.tryParse(event.date);

    final i = AppCategory.categories.indexWhere(
      (c) => c.id == event.categoryId,
    );
    index = i < 0 ? 0 : i;
    selectedCategory = AppCategory.categories[index];
  }

  Future<void> updateEvent(BuildContext context, EventModel old) async {
    isLoading = true;
    notifyListeners();

    final updated = EventModel(
      id: old.id,
      userId: old.userId,
      usersFav: old.usersFav,
      title: titleController.text,
      desc: descriptionController.text,
      categoryId: selectedCategory.id,
      date: selectedDateTime?.toString() ?? old.date,
      time: selectedTime?.format(context) ?? old.time,
    );

    await DatabaseService.updateEvent(updated);
    isLoading = false;
    notifyListeners();

    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
