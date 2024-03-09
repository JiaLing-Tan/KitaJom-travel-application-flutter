import 'package:cloud_firestore/cloud_firestore.dart';

class Accommodation {
  final List<String> amenities;
  final String accommodationType;
  final String address;
  final String description;
  final bool isAvailable;
  final String listingName;
  final String listingType;
  final List<String> photos;
  final int rating;
  final List<Map> roomTypes;
  final String vendorId;
  final String listingId;
  final List<Map> userReviews;
  final List<Timestamp> unavailableDate;

  const Accommodation({
    required this.amenities,
    required this.accommodationType,
    required this.address,
    required this.description,
    required this.isAvailable,
    required this.listingName,
    required this.listingType,
    required this.photos,
    required this.rating,
    required this.roomTypes,
    required this.vendorId,
    required this.listingId,
    required this.userReviews,
    required this.unavailableDate
  });

  static Accommodation fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Accommodation(
      amenities: snapshot["amenities"].cast<String>(),
      accommodationType: snapshot['accommodationType'],
      address: snapshot['address'],
      description: snapshot['description'],
      isAvailable: snapshot['isAvailable'],
      listingName: snapshot['listingName'],
      listingType: snapshot['listingType'],
      photos: snapshot['photos'].cast<String>(),
      rating: snapshot['rating'].round(),
      roomTypes: snapshot['roomTypes'].cast<Map<String, dynamic>>(),
      vendorId: snapshot['vendorId'],
      listingId: snapshot['listingId'],
        unavailableDate:snapshot['unavailableDate'].cast<Timestamp>(),
        userReviews: snapshot['userReviews']?.cast<Map<String, dynamic>>() ?? {}
    );
  }
}
