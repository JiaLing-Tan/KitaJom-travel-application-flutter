import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../model/booking.dart';

class BookingController {
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('booking');

  Future<void> createBooking(Booking booking) async {
    var uuid = const Uuid();
    String newUuid = uuid.v4();
    await bookingsCollection.doc(newUuid).set({
      "confirmationNumber": newUuid,
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "checkIn": booking.checkIn,
      "checkOut": booking.checkOut,
      "listingId": booking.listingId,
      "night": booking.night,
      "totalAmount": booking.totalAmount,
      "timestamp": Timestamp.now(),
      "listingType": "accommodation",
    });

    List<DateTime> days = [];
    for (int i = 0;
        i <
            DateTime.parse(booking.checkOut)
                .difference(DateTime.parse(booking.checkIn))
                .inDays;
        i++) {
      days.add(DateTime.parse(booking.checkIn).add(Duration(days: i)));
    }

    await FirebaseFirestore.instance
        .collection('accommodation')
        .doc(booking.listingId)
        .update({"unavailableDate": FieldValue.arrayUnion(days)});
  }

  Future<void> createTicket(Booking booking) async {
    var uuid = const Uuid();
    String newUuid = uuid.v4();
    await bookingsCollection.doc(newUuid).set({
      "confirmationNumber": newUuid,
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "listingId": booking.listingId,
      "totalAmount": booking.totalAmount,
      "timestamp": Timestamp.now(),
      "listingType": "activity",
      "ticketType": booking.ticketType,
    });
  }

  Stream<QuerySnapshot> getBookings() {
    return bookingsCollection.snapshots();
  }
}
