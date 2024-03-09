import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitajom/resources/CRUD/review.dart';
import 'package:kitajom/resources/storage_methods.dart';

class ReviewProvider extends ChangeNotifier {
  List<Map<dynamic,dynamic>> _userReviews = [];
  List<Map<dynamic,dynamic>> get userReviews => _userReviews;
  List<String> _photoUrl = [];

  bool isBusy = true;
  bool get IsBusy => isBusy;
  set IsBusy(bool data) {
    this.isBusy = data;
    notifyListeners();
  }
  void maketru(){
    IsBusy=false;
  }

  List<String> get photoUrl => _photoUrl;
  num _rating = 0;

  num get rating => _rating;
  String _desc = "";

  String get desc => _desc;
  String _listingId = '';
  String _listingType = "";
  num _finalRate = 0;
  num _finalNum = 0;
  num _finalRateSum = 0;
  num get finalRateSum => _finalRateSum;

  Future<void> setImage(List<Uint8List> imageFileList) async {
    _photoUrl = [];
    for (Uint8List i in imageFileList) {
      _photoUrl.add(
          await StorageMethods().uploadImageToStorage('reviewPics', i, true));
    }
  }

  void setRating(num rating) {
    _rating = rating;
  }

  void setListing(String listingId, String listingType){
    _listingId = listingId;
    _listingType = listingType;
  }

  void setDescription(String desc) {
    _desc = desc;
  }

  void setFinalRate(num sumNum, num sumRate) {
    _finalRate = sumRate;
    _finalNum = sumNum;

  }

  void setFinalRateSum(num rateSum){
    _finalRateSum = rateSum.round();
    notifyListeners();
  }

  void createReview(){
    _finalRateSum = ((_finalRate + _rating)/(_finalNum + 1)).round();
    ReviewController().addReview(listingType: _listingType, listingId: _listingId, rating: _rating, photoUrl: _photoUrl, description: _desc, finalRate: _finalRateSum);
    notifyListeners();
  }

  void refresh(){
    notifyListeners();
  }

  void setReview(List<Map<dynamic,dynamic>> userReviews){
    _userReviews = userReviews;
  }
}
