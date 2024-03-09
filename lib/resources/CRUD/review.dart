import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ReviewController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<String> addReview(
      {required String listingType,
      required String listingId,
      required num rating,
      required List<String> photoUrl,
      required String description,
      required num finalRate}) async {
    String res = "Some error occured";
    var uuid = const Uuid();
    String newReviewId = uuid.v4();

    try {
      await _firestore.collection(listingType).doc(listingId).update({
        "userReviews": FieldValue.arrayUnion([
          {
            'description': description,
            'photoUrl': photoUrl,
            'rating': rating,
            'vendorReply': "",
            'userId': FirebaseAuth.instance.currentUser?.uid,
            'reviewId': newReviewId
          }
        ])
      });

      await _firestore.collection(listingType).doc(listingId).update(
          {"rating": finalRate});
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
