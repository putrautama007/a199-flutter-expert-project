import 'package:flutter/material.dart';

class BottomNavNotifier extends ChangeNotifier {
  int tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
