import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String address;
  final List<String> cuisine;
  final String description;
  final bool isAvailable;
  final String listingName;
  final String listingType;
  final String openingHours;
  final List<String> photos;
  final String pricePoint;
  final int rating;
  final String vendorId;
  final String listingId;
  final List<Map> userReviews;

  const Restaurant({
    required this.listingId,
    required this.address,
    required this.cuisine,
    required this.description,
    required this.isAvailable,
    required this.listingName,
    required this.listingType,
    required this.openingHours,
    required this.photos,
    required this.pricePoint,
    required this.rating,
    required this.vendorId,
    required this.userReviews
  });

  static Restaurant fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Restaurant(
        address: snapshot["address"],
        cuisine: snapshot["cuisine"].cast<String>(),
        description: snapshot["description"],
        isAvailable: snapshot["isAvailable"],
        listingName: snapshot["listingName"],
        listingType: snapshot["listingType"],
        openingHours: snapshot["openingHours"],
        photos: snapshot["photos"].cast<String>(),
        pricePoint: snapshot["pricePoint"],
        rating: snapshot["rating"],
        vendorId: snapshot["vendorId"],
        listingId: snapshot["listingId"],
        userReviews:
            snapshot['userReviews']?.cast<Map<String, dynamic>>() ?? {});
  }
}
