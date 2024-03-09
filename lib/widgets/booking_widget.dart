import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/model/booking.dart';
import 'package:kitajom/screens/booking_detail_screen.dart';

class BookingWidget extends StatefulWidget {
  final Booking booking;

  BookingWidget({
    super.key,
    required this.booking,
  });

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  String accommodationName = "";

  void initState() {
    super.initState();
    getAccommodationName();
  }

  void getAccommodationName() async {
    DocumentSnapshot snapAccommodation = await FirebaseFirestore.instance
        .collection('accommodation')
        .doc(widget.booking.listingId)
        .get();
    setState(() {
      accommodationName =
      (snapAccommodation.data() as Map<String, dynamic>)['listingName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Booking booking = this.widget.booking;
    int night = booking.night;
    num totalAmount = booking.totalAmount;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                     BookingDetailScreen(booking: booking)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(25, 25, 5, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox( width: 200, child: Text(accommodationName, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Confirmation number", style: TextStyle(fontWeight: FontWeight.w500),),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 10.0),
                      child: Text(booking.confirmationNumber, style: TextStyle(color: Colors.grey, fontSize: 12),),
                    ),
                  ],
                ),
                Text("Check-in", style: TextStyle(fontWeight: FontWeight.w500),),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(booking.checkIn),
                ),
                const Text("Check-out", style: TextStyle(fontWeight: FontWeight.w500),),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(booking.checkOut),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
