import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/screens/report_button.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../model/booking.dart';

class BookingDetailScreen extends StatefulWidget {
  final Booking booking;

  BookingDetailScreen({super.key, required this.booking});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  String accommodationName = "";
  String attractionName = "";
  bool _isAccommodation = true;


  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    DocumentSnapshot snapAccommodation = await FirebaseFirestore.instance
        .collection('accommodation')
        .doc(widget.booking.listingId)
        .get();
    DocumentSnapshot snapAttraction = await FirebaseFirestore.instance
        .collection('activity')
        .doc(widget.booking.listingId)
        .get();
    setState(() {
      if (snapAccommodation.data() == null){
        attractionName = (snapAttraction.data() as Map<String, dynamic>)['listingName'];
        _isAccommodation = false;
      }else
      {
        accommodationName =
            (snapAccommodation.data() as Map<String, dynamic>)['listingName'];
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          toolbarHeight: 100,
          title: const Text("Booking Details"),
          centerTitle: true,
          actions: const [
            ReportButton(),
          ]),
      body: SingleChildScrollView(
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
                        _isAccommodation? accommodationName: attractionName,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                    const Divider(
                      color: mainGreen,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Confirmation number",
                            style:
                                TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            widget.booking.confirmationNumber,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: mainGreen,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 10, top: 10),
                      child: _isAccommodation? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Check-in",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(widget.booking.checkIn),
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
                          Text(widget.booking.checkOut),
                          Text("Before 12:00 PM (12: 00)"),
                        ],
                      ): Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text(
                        "Ticket Summary",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),Wrap(
                        children: List.generate(
                            widget.booking.ticketType.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.booking.ticketType[index]
                                      ['ticketName'],
                                    ),
                                    Text(
                                      "x" +
                                          widget.booking.ticketType[index]
                                          ['number']
                                              .toString(),
                                    ),
                                  ],
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "RM" +
                                         widget.booking.ticketType[index]
                                          ['price']
                                              .toString(),
                                    )),
                              ],
                            ),
                          );
                        }),
                      ),],),
                    ),
                    const Divider(
                      color: mainGreen,
                    ),
                    _isAccommodation? Padding(
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
                              Text(widget.booking.night.toString()),
                              Text(widget.booking.night == 1 ? " night" : " nights"),
                            ],
                          ),
                        ],
                      ),
                    ): SizedBox(),
                    _isAccommodation? const Divider(
                      color: mainGreen,
                    ): SizedBox(),
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
            
                          Text("RM " + widget.booking.totalAmount.toString()),
                        ],
                      ),
                    ),
                    const Divider(
                      color: mainGreen,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: QrImageView(
                          data: widget.booking.confirmationNumber,
                          version: QrVersions.auto,
                          size: 280.0,
            
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
