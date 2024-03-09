import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/model/booking.dart';
import 'package:kitajom/widgets/booking_widget.dart';
import 'package:kitajom/widgets/ticket_widget.dart';

class BookingList extends StatelessWidget {
  final String listingType;

  const BookingList({super.key, required this.listingType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('booking')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('listingType', isEqualTo: listingType)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            var bookings = snapshot.data!.docs.map((doc) {
              if (listingType == "accommodation") {
                return Booking.bookingFromSnap(doc);
              } else {
                return Booking.ticketFromSnap(doc);
              }
            }).toList();

            bookings.sort((a, b) => (b!.timestamp).compareTo(a!.timestamp));

            return bookings.isEmpty
                ? const Center(child: Text("No booking has been made yet!"))
                : ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      var booking = bookings[index];
                      Key tileKey = Key(booking!.confirmationNumber);
                      if (listingType == "accommodation") {
                        return BookingWidget(booking: booking);
                      } else {
                        return TicketWidget(booking: booking);
                      }
                    },
                  );
          }
        },
      ),
    );
  }
}
