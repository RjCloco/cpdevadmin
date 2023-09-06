
import 'package:flutter/material.dart';

class SidebarProvider extends ChangeNotifier {

  int currentPageIndex = 0;
  int index =0;
  int first =0;
  int second =0;
  int third =0;
  String Vname = "";

  //int get currentPageIndex => _currentPageIndex;

  void navigateToPage(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

}
