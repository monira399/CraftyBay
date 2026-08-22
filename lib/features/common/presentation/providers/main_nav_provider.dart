import 'package:flutter/material.dart';

class MainNavProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeItem(int index) {
    if(_selectedIndex == index) return;

    _selectedIndex = index;
    notifyListeners();
  }


  void backToHome() {
    changeItem(0);
  }

  void changeCategories() {
    changeItem(1);
  }
}