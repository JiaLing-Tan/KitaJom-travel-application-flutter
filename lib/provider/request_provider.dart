import 'package:flutter/material.dart';

class RequestProvider extends ChangeNotifier {
  String _request =
      "Say this: Welcome to Kita Jom Itinerary Generator, use the filter above to customize your itinerary!";

  String get request => _request;
  String _location = "Location";
  String get location => _location;
  String _day = "Day";

  String get day => _day;
  final List<String> _filter = [];
  int _locationIndex = 0;

  int get locationIndex => _locationIndex;
  final List<int> _filterIndex = [];

  List<int> get filterIndex => _filterIndex;

  void notify() {
    notifyListeners();
  }

  void generateRequest() {
    if (_day == "Day" || _location == "Location") {
      _request = "say: Please select a destination and number of day";
    } else {
      if (_day == "1") {
        _request = "Generate an itinerary in$_location for a day trip with the condition:${_filter.join(",")}";
      } else {
        int night = int.parse(_day) - 1;
        _request = "Generate an itinerary in$_location for $_day day and $night night trip with the condition:${_filter.join(",")}";
      }
    }

    _request = request;
  }

  void setLocation(String location) {
    _location = location;
  }

  void setFilter(String filter) {
    _filter.add(filter);
  }

  void setDay(String day) {
    _day = day;
  }

  void setLocationIndex(int index) {
    _locationIndex = index;
  }

  void setFilterIndex(int index) {
    _filterIndex.add(index);
  }

  void removeFilterIndex(int index) {
    _filterIndex.remove(index);
  }

  void removeFilter(String filter) {
    _filter.remove(filter);
  }
}
