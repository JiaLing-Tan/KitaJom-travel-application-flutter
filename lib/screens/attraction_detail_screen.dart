import 'package:flutter/material.dart';
import 'package:kitajom/model/attraction.dart';
import 'package:kitajom/provider/booking_provider.dart';
import 'package:kitajom/screens/payment_ticket_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/utils/map.dart';
import 'package:kitajom/utils/utils.dart';
import 'package:kitajom/widgets/bookmark_button.dart';
import 'package:kitajom/widgets/button.dart';
import 'package:kitajom/widgets/image_slider.dart';
import 'package:kitajom/widgets/rating_widget.dart';
import 'package:kitajom/widgets/ticket_count_widget.dart';
import 'package:provider/provider.dart';

class AttractionDetailScreen extends StatefulWidget {
  final Attraction attraction;

  const AttractionDetailScreen({super.key, required this.attraction});

  @override
  State<AttractionDetailScreen> createState() => _ExploreState();
}

class _ExploreState extends State<AttractionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, value, child) => PopScope(
        onPopInvoked: (bool didPop) {
          if (didPop) {
            value.clearTotal();
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
                        imageList: widget.attraction.photos,
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
                                    widget.attraction.listingName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              BookmarkButton(listingId: widget.attraction.listingId),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                RatingWidget(isReview: false, rating: widget.attraction.rating),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${widget.attraction.rating}.0",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "View Review",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      decoration: TextDecoration.underline),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Leave Review",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      decoration: TextDecoration.underline),

                                )

                              ],
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.only(bottom: 10.0),
                            child: Text(widget.attraction.pricePoint, style: TextStyle(color: mainGreen, fontWeight: FontWeight.w700, fontSize: 20),),
                          ),

                          Text(
                            "Opening hours",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(widget.attraction.openingHours),
                          ),

                          Text(
                            "Address",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: (){
                              MapUtils.openMap(widget.attraction.address);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Text(widget.attraction.address, style: TextStyle(fontWeight: FontWeight.w500, color:mainGreen, decoration: TextDecoration.underline),),
                            ),
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(widget.attraction.description),
                          ),
                          Text(
                            "Duration",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(widget.attraction.duration),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  "Age Restriction:  ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 16),
                                ),
                                Text(widget.attraction.ageRestrictions),
                              ],
                            ),
                          ),
                          Text(
                            "Activities",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children:
                              List.generate(widget.attraction.activities.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: mainGreen)), child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(widget.attraction.activities[index],),
                                  ),),
                                );
                              }),

                            ),
                          ),
                          TicketCountWidget(
                            attraction: widget.attraction,
                            value: value,
                          ),
                          const SizedBox(
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
                        offset: const Offset(0, 3), // changes position of shadow
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
                            Text("RM" + value.totalAmount.toString(),
                                style:
                                    const TextStyle(fontSize: 25, color: mainGreen)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                          child: SizedBox(
                            height: 50,
                            width: 110,
                            child: MyButton(
                                onTap: () {
                                  if (value.totalAmount > 0) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                           PaymentTicketScreen(attraction: widget.attraction,),
                                    ));
                                  }else{
                                    showSnackBar("You haven't select anything yet.", context);
                                  }
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
