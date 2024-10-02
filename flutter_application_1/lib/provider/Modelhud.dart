import 'package:flutter/material.dart';

class Modelhud extends ChangeNotifier {
  bool isLoading = false;

  changeisLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
