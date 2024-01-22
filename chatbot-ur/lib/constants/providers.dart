import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier{
  String _currentpage = 'home';
  String get currentPage => _currentpage;
  void setpage(String page){
    _currentpage = page;
    notifyListeners();
  }
}