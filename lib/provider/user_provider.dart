import 'package:flutter/material.dart';
import 'package:kitajom/model/user.dart';

import '../resources/auth_method.dart';

class UserProvider with ChangeNotifier {

  User? _user;
  final Authentication _authMethods = Authentication();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

  void setUser(User user){
    _user = user;
  }

  void setListingId(List<String> listingId) {
    _user?.bookmark = listingId;
    notifyListeners();
  }

  void addBookmark(String listingId) {
    _user?.bookmark.add(listingId);
    notifyListeners();
  }

  void removeBookmark(String listingId) {
    _user?.bookmark.remove(listingId);
    notifyListeners();
  }




}