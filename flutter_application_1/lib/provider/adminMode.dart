import 'package:flutter/material.dart';

class adminMode extends ChangeNotifier {
  String id = 'adminMode';
  bool isAdmin = false;
  changeisadmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
