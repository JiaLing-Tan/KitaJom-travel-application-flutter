import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Booking {
  String confirmationNumber;
  String userId;
  String listingId;
  String checkIn;
  String checkOut;
  int night;
  num totalAmount;
  DateTime timestamp;
  List<Map<String, dynamic>> ticketType;

  Booking({
    this.confirmationNumber = "",
    this.userId = "",
    this.checkIn = "",
    this.checkOut = "",
    required this.listingId,
    this.night = 0,
    required this.totalAmount,
    required this.timestamp,
    this.ticketType = const [
      {"": ""}
    ],
  });

  static Booking bookingFromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Booking(
        confirmationNumber: snapshot["confirmationNumber"],
        night: snapshot["night"],
        userId: snapshot["userId"],
        checkIn: DateFormat('(E) dd, MMM y').format(DateTime.parse(snapshot["checkIn"])),
        checkOut: DateFormat('(E) dd, MMM y').format(DateTime.parse(snapshot["checkOut"])),
        listingId: snapshot["listingId"],
        totalAmount: snapshot["totalAmount"],
        timestamp: snapshot["timestamp"].toDate(),
    );
  }

  static Booking ticketFromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Booking(
      confirmationNumber: snapshot["confirmationNumber"],
      userId: snapshot["userId"],
      listingId: snapshot["listingId"],
      totalAmount: snapshot["totalAmount"],
      timestamp: snapshot["timestamp"].toDate(),
      ticketType: snapshot["ticketType"]?.cast<Map<String, dynamic>>() ?? [],
    );
  }


}
