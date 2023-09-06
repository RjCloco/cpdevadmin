
import 'package:flutter/material.dart';

class SidebarProvider extends ChangeNotifier {

  int currentPageIndex = 0;
  //int get currentPageIndex => _currentPageIndex;

  void navigateToPage(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

}
