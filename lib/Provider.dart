
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SidebarProvider extends ChangeNotifier {

  int currentPageIndex = 0;
  int index =0;
  int first =0;
  int second =0;
  int third =0;
  String Vname = "";
   List<DocumentSnapshot<Object?>> stationData=[];

  //int get currentPageIndex => _currentPageIndex;

  void navigateToPage(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

}
