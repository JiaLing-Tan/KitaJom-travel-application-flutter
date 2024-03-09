import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitajom/model/accommodation.dart';
import 'package:kitajom/model/attraction.dart';

class BookingProvider extends ChangeNotifier {
  String _checkIn = DateTime.now().toString();
  String _checkOut = DateTime.now().add(Duration(days: 1)).toString();
  int _night = 1;

  int get night => _night;

  String get checkIn => _checkIn;

  String get checkOut => _checkOut;
  int _totalAmount = 0;


  Accommodation _accommodation = const Accommodation(
      unavailableDate: [],
      amenities: [],
      accommodationType: "accommodationType",
      address: "address",
      description: "description",
      isAvailable: true,
      listingName: "listingName",
      listingType: "listingType",
      photos: [],
      rating: 0,
      roomTypes: [],
      vendorId: "vendorId",
      listingId: "listingId",
      userReviews: []);

  Attraction _attraction = const Attraction(
      activities: [],
      activityType: "activityType",
      address: "address",
      ageRestrictions: "ageRestrictions",
      description: "description",
      duration: "duration",
      isAvailable: true,
      listingName: "listingName",
      listingType: "listingType",
      openingHours: "openingHours",
      photos: [],
      pricePoint: "pricePoint",
      rating: 0,
      ticketPrice: [],
      vendorId: "vendorId",
      listingId: "listingId",
      userReviews: []);
  Map<String, int> _ticketNumbers = {};

  Map<String, int> get ticketNumbers => _ticketNumbers;

  List<Map<String, dynamic>> ticketType() {
    List<Map<String, dynamic>> newList = [];
    for (Map i in attraction.ticketPrice) {
      Map<String, dynamic> newMap = {};
      if (ticketNumbers[i["name"]]! > 0) {
        print(ticketNumbers[i["name"]]);
        newMap["price"] = i["price"];
        newMap["ticketName"] = i["name"];
        newMap["number"] = _ticketNumbers[i["name"]];
        newList.add(newMap);
      }
    }
    print(newList);
    return newList;
  }

  int get totalAmount => _totalAmount;

  Attraction get attraction => _attraction;

  void notify() {
    notifyListeners();
  }

  void setTotal(int amount, String method, Map<String, int> ticketNumber) {
    if (method == "add") {
      _totalAmount += amount;
    } else if (method == "subtract") {
      _totalAmount -= amount;
    }
    _ticketNumbers = ticketNumber;
    print(_ticketNumbers);
    notifyListeners();
  }

  void sumTotal(int price, List<DateTime?> selectedDate) {
    _totalAmount = ((selectedDate[1]?.difference(selectedDate[0]!).inDays)! * price);
    _checkIn = selectedDate.first.toString();
    _checkOut = selectedDate.last.toString();
    _night = (selectedDate[1]?.difference(selectedDate[0]!).inDays)!  ;
    print(_night);
    notifyListeners();
    print("oit");
  }

  void setAttraction(Attraction attraction) {
    _attraction = attraction;
  }

  void setAccommodation(Accommodation accommodation) {
    _accommodation = accommodation;
  }

  void clearTotal() {
    _totalAmount = 0;
    _checkIn = DateTime.now().toString();
    _checkOut = DateTime.now().add(Duration(days: 1)).toString();
    _night = 1;
    notifyListeners();
  }
}
