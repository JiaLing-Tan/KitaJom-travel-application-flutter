import 'package:flutter/cupertino.dart';

class FilterProvider extends ChangeNotifier{
  String _location = "ok";
  String get location => _location;
  int _locationIndex = 0;
  int get locationIndex => _locationIndex;

  void setLocation(String location){
    _location = location;
  }

  void setLocationIndex(int index){
    _locationIndex = index;
  }

  void notify(){
    notifyListeners();
  }



}