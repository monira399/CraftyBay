import 'package:craftybay/app/app.dart';
import 'package:craftybay/features/auth/presentation/providers/auth_controllers.dart';
import 'package:craftybay/features/auth/presentation/screens/sign_In_screen.dart';
import 'package:flutter/material.dart';

class MainNavProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

 Future<void>  changeItem(int index) async{
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