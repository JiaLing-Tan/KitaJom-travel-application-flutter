import 'package:cloud_firestore/cloud_firestore.dart';

class Attraction {
  final List<String> activities;
  final String activityType;
  final String address;
  final String ageRestrictions;
  final String description;
  final String duration;
  final bool isAvailable;
  final String listingName;
  final String listingType;
  final String openingHours;
  final List<String> photos;
  final String pricePoint;
  final int rating;
  final List<Map> ticketPrice;
  final String vendorId;
  final String listingId;
  final List<Map> userReviews;

  const Attraction(
      {required this.activities,
      required this.activityType,
      required this.address,
      required this.ageRestrictions,
      required this.description,
      required this.duration,
      required this.isAvailable,
      required this.listingName,
      required this.listingType,
      required this.openingHours,
      required this.photos,
      required this.pricePoint,
      required this.rating,
      required this.ticketPrice,
      required this.vendorId,
      required this.listingId,
      required this.userReviews});

  static Attraction fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Attraction(
        activities: snapshot['activities'].cast<String>(),
        activityType: snapshot['activityType'],
        address: snapshot['address'],
        ageRestrictions: snapshot['ageRestrictions'],
        description: snapshot['description'],
        duration: snapshot['duration'],
        isAvailable: snapshot['isAvailable'],
        listingName: snapshot['listingName'],
        listingType: snapshot['listingType'],
        openingHours: snapshot['openingHours'],
        photos: snapshot['photos'].cast<String>(),
        pricePoint: snapshot['pricePoint'],
        rating: snapshot['rating'],
        ticketPrice: snapshot['ticketPrice'].cast<Map<String, dynamic>>(),
        listingId: snapshot['listingId'],
        vendorId: snapshot['vendorId'],
        userReviews: snapshot['userReviews']?.cast<Map<String, dynamic>>() ?? {});
  }
}
