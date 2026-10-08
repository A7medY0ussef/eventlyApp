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
}
