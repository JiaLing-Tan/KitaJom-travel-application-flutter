import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/model/accommodation.dart';
import 'package:kitajom/model/booking.dart';
import 'package:kitajom/provider/booking_provider.dart';
import 'package:kitajom/resources/CRUD/booking.dart';
import 'package:kitajom/resources/local_notification.dart';
import 'package:kitajom/screens/dashboard_screen.dart';
import 'package:kitajom/screens/payment_proceed_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/button.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_pic.dart';

class PaymentBookingScreen extends StatefulWidget {
  final Accommodation accommodation;

  const PaymentBookingScreen({super.key, required this.accommodation});

  @override
  State<PaymentBookingScreen> createState() => _PaymentBookingScreenState();
}

class _PaymentBookingScreenState extends State<PaymentBookingScreen> {
  String firstName = "";
  String lastName = "";
  String accommodationName = "";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    DocumentSnapshot snapUser = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    DocumentSnapshot snapAccommodation = await FirebaseFirestore.instance
        .collection('accommodation')
        .doc(widget.accommodation.listingId)
        .get();
    setState(() {
      accommodationName =
          (snapAccommodation.data() as Map<String, dynamic>)['listingName'];
      firstName = (snapUser.data() as Map<String, dynamic>)['firstName'];
      lastName = (snapUser.data() as Map<String, dynamic>)['lastName'];
    });
  }

  void confirmPayment(BookingProvider value) {
    Booking newTicket = Booking(
        listingId: widget.accommodation.listingId,
        timestamp: DateTime.now(),
        totalAmount: value.totalAmount,
        night: value.night,
        checkOut: value.checkOut,
        checkIn: value.checkIn,
    );
    BookingController().createBooking(newTicket);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, value, child) => PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          DashboardScreen.showBackDialog(
              "Are you sure you wanna give up the booking?", context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              toolbarHeight: 100,
              title: Text("Payment"),
              centerTitle: true,
              actions: [
                Container(
                  child: ProfilePic(),
                ),
              ]),
          body: Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, left: 10),
                            child: Text(
                              accommodationName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ),
                          Divider(
                            color: mainGreen,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Check-in",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                Text(value.checkIn.split(" ")[0]),
                                Text("After 3:00 PM (15: 00)"),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Check-out",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                Text(value.checkOut.split(" ")[0]),
                                Text("Before 12:00 PM (12: 00)"),
                              ],
                            ),
                          ),
                          Divider(
                            color: mainGreen,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Night",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Text(value.night.toString()),
                                    Text(value.night == 1 ? " night" : " nights"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: mainGreen,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount Paid",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                Text("RM " + value.totalAmount.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: SizedBox(
                  width: 300,
                  height: 47,
                  child: MyButton(
                    buttonText: "Confirm Payment",
                    color: mainGreen,
                    onTap: () async {
                      confirmPayment(value);
                      await LocalNotification.showNotification(
                          title: "Payment done! ",
                          body: "Get ready for the journey!");
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PaymentProceed()));
                    },
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
