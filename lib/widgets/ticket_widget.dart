import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/model/booking.dart';
import 'package:kitajom/screens/booking_detail_screen.dart';
import 'package:kitajom/utils/colors.dart';

class TicketWidget extends StatefulWidget {
  final Booking booking;

  const TicketWidget({
    super.key,
    required this.booking,
  });

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  late String name = "";
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  void getName() async {
    setState(() {
      _isLoading = true;
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('activity')
        .doc(widget.booking.listingId)
        .get();
    setState(() {
      _isLoading = false;
      name = (snap.data() as Map<String, dynamic>)['listingName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Booking booking = this.widget.booking;
    return _isLoading
        ? SizedBox(
            height: 40,
            width: 20,
            child: Center(child: CircularProgressIndicator()))
        : Padding(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 20, 25, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: SizedBox(
                            child: Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )),
                      ),
                      Text("Ticket", style: TextStyle(fontWeight: FontWeight.w500),),
                      Divider(color: mainGreen,),
                      Wrap(
                        children:
                            List.generate(booking.ticketType.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  booking.ticketType[index]['ticketName'],
                                ),
                                Text(
                                  "x" +
                                      booking.ticketType[index]['number']
                                          .toString(),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
