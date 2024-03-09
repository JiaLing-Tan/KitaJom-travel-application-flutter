import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/model/attraction.dart';
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

class PaymentTicketScreen extends StatefulWidget {
  final Attraction attraction;

  const PaymentTicketScreen({super.key, required this.attraction});

  @override
  State<PaymentTicketScreen> createState() => _PaymentTicketScreenState();
}

class _PaymentTicketScreenState extends State<PaymentTicketScreen> {
  String firstName = "";
  String lastName = "";

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
    setState(() {
      firstName = (snapUser.data() as Map<String, dynamic>)['firstName'];
      lastName = (snapUser.data() as Map<String, dynamic>)['lastName'];
    });
  }

  void confirmPayment(BookingProvider value) {
    Booking newTicket = Booking(
        listingId: widget.attraction.listingId,
        timestamp: DateTime.now(),
        totalAmount: value.totalAmount,
        ticketType: value.ticketType());
    BookingController().createTicket(newTicket);
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
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, left: 10),
                            child: Text(
                              value.attraction.listingName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ),
                          Divider(
                            color: mainGreen,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 10, top: 10),
                            child: Text(
                              "Ticket Summary",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10),
                            child: Column(
                              children: [
                                Wrap(
                                  children: List.generate(
                                      value.ticketType().length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                value.ticketType()[index]
                                                    ['ticketName'],
                                              ),
                                              Text(
                                                "x" +
                                                    value
                                                        .ticketType()[index]
                                                            ['number']
                                                        .toString(),
                                              ),
                                            ],
                                          ),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "RM" +
                                                    value
                                                        .ticketType()[index]
                                                            ['price']
                                                        .toString(),
                                              )),
                                        ],
                                      ),
                                    );
                                  }),
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
                                Text("Amount Paid", style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),),
                                Text("RM " + value.totalAmount.toString()),
                              ],
                            ),
                          ),
                          Divider(
                            color: mainGreen,
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
