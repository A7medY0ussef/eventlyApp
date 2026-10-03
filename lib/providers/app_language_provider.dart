import 'package:flutter/cupertino.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';

  void changeLanguage(String currentLanguage) {
    if (appLanguage == currentLanguage) {
      return;
    } else {
      appLanguage = currentLanguage;
      notifyListeners();
    }
  }
}
