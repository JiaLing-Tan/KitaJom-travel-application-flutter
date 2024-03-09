import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier{
  int _page = 0;
  int get page => _page;
  late PageController _pageController;
  PageController get pageController => _pageController;

  void setPage(int page) {
    _pageController.jumpToPage(page);
    _page = page;
    notifyListeners();
  }

  void goDispose(){
    _pageController.dispose();
  }

  void createPageController(PageController pageController){
    _pageController = pageController;
  }





}