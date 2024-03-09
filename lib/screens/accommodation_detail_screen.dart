import 'package:flutter/material.dart';
import 'package:kitajom/model/accommodation.dart';
import 'package:kitajom/provider/booking_provider.dart';
import 'package:kitajom/provider/review_provider.dart';
import 'package:kitajom/screens/payment_booking_screen.dart';
import 'package:kitajom/screens/review_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/utils/map.dart';
import 'package:kitajom/utils/utils.dart';
import 'package:kitajom/widgets/amenities_widget.dart';
import 'package:kitajom/widgets/bookmark_button.dart';
import 'package:kitajom/widgets/button.dart';
import 'package:kitajom/widgets/image_slider.dart';
import 'package:kitajom/widgets/rating_widget.dart';
import 'package:kitajom/widgets/review_list.dart';
import 'package:provider/provider.dart';

import '../widgets/booking_count_widget.dart';

class AccommodationDetailScreen extends StatefulWidget {
  final Accommodation accommodation;

  const AccommodationDetailScreen({super.key, required this.accommodation});

  @override
  State<AccommodationDetailScreen> createState() => _ExploreState();
}

class _ExploreState extends State<AccommodationDetailScreen> {

  void _tapReview() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
            width: double.infinity, child: ReviewList(listingId: widget.accommodation.listingId,)));
  }

  void _tapCreate() {
    Provider.of<ReviewProvider>(context, listen: false).setListing(widget.accommodation.listingId, widget.accommodation.listingType);
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                ReviewScreen()));
  }

  @override
  Widget build(BuildContext context) {

    var finalRate = Provider.of<ReviewProvider>(context, listen: true).finalRateSum;

    num sumRate = 0;
    for (Map<dynamic, dynamic> i in widget.accommodation.userReviews) {
      sumRate += i['rating'];
    }
    Provider.of<ReviewProvider>(context, listen: false)
        .setFinalRate(widget.accommodation.userReviews.length, sumRate);
    Provider.of<ReviewProvider>(context, listen: false)
        .setFinalRateSum(widget.accommodation.rating);


    return Consumer2<ReviewProvider, BookingProvider>(
      builder: (context, ReviewProvider, BookingProvider, child) => PopScope(
        onPopInvoked: (bool didPop) {
          if (didPop) {
            BookingProvider.clearTotal();
            return;
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: ImageSlider(
                        imageList: widget.accommodation.photos,
                      ),
                    ),
                    AppBar(
                      toolbarHeight: 100,
                      backgroundColor: Colors.transparent,
                    )
                  ]),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 250,
                                  child: Text(
                                    widget.accommodation.listingName,
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  )),
                              BookmarkButton(
                                  listingId: widget.accommodation.listingId),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                RatingWidget(
                                    isReview: false,
                                    rating: finalRate==0? widget.accommodation.rating:finalRate),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${finalRate==0? widget.accommodation.rating:finalRate}.0",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),

                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: _tapReview,
                                  child: Text(
                                    "View Review",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline),

                                  ),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: _tapCreate,
                                  child: Text(
                                    "Leave Review",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline),

                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "Address",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: (){
                              MapUtils.openMap(widget.accommodation.address);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Text(widget.accommodation.address, style: TextStyle(fontWeight: FontWeight.w500, color:mainGreen, decoration: TextDecoration.underline),),
                            ),
                          ),

                          Text("Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(widget.accommodation.description),
                          ),
                          Text(
                            "Amenities",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: List.generate(
                                    widget.accommodation.amenities.length,
                                        (index) {
                                      return AmenitiesWidget(
                                          amenity: widget
                                              .accommodation.amenities[index]
                                              .toString());
                                    })),
                          ),
                          Padding(
                            padding:const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.bed),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Room", style: TextStyle(fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    widget.accommodation.roomTypes[0]['bed']
                                        .toString().split(", ").length,
                                        (index) {
                                      return Text( widget.accommodation.roomTypes[0]['bed']
                                          .toString().split(", ")[index]);
                                    })),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Icon(Icons.people),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(widget.accommodation.roomTypes[0]['pax']
                                    .toString(), style: TextStyle(fontWeight: FontWeight.w500),)
                              ],
                            ),

                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                Icon(Icons.attach_money),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("RM " +
                                    widget.accommodation.roomTypes[0]['price']
                                        .round()
                                        .toString(), style: TextStyle(fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          Text("Booking Dates",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),),
                          BookingCountWidget(
                            accommodation: widget.accommodation,
                            value: BookingProvider,
                          ),
                          SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.maxFinite,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Total  :",
                              style: TextStyle(fontSize: 25),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("RM" + BookingProvider.totalAmount.toString(),
                                style: const TextStyle(
                                    fontSize: 25, color: mainGreen)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                          child: SizedBox(
                            height: 50,
                            width: 110,
                            child: MyButton(
                                onTap: () {
                                  if (BookingProvider.totalAmount > 0) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentBookingScreen(
                                        accommodation: widget.accommodation,
                                      ),
                                    ));
                                  } else {
                                    showSnackBar(
                                        "You haven't select anything yet.",
                                        context);
                                  }
                                  //value.setAttraction(widget.attraction);
                                },
                                buttonText: "Book",
                                color: mainGreen),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
