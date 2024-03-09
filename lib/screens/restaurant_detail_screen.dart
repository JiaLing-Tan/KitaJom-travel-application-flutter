import 'package:flutter/material.dart';
import 'package:kitajom/model/restaurant.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/utils/map.dart';
import 'package:kitajom/widgets/bookmark_button.dart';
import 'package:kitajom/widgets/image_slider.dart';
import 'package:kitajom/widgets/rating_widget.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _ExploreState();
}

class _ExploreState extends State<RestaurantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: ImageSlider(imageList: widget.restaurant.photos),
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
                              widget.restaurant.listingName,
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            )),
                        BookmarkButton(listingId: widget.restaurant.listingId),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          RatingWidget(
                            isReview: false,
                            rating: widget.restaurant.rating,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.restaurant.rating}.0",
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
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(widget.restaurant.pricePoint, style: TextStyle(color: mainGreen, fontWeight: FontWeight.w700, fontSize: 20),),
                    ),
                    Text(
                      "Opening hours",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(widget.restaurant.openingHours),
                    ),
                    Text(
                      "Address",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: (){
                        MapUtils.openMap(widget.restaurant.address);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(widget.restaurant.address, style: TextStyle(fontWeight: FontWeight.w500, color:mainGreen, decoration: TextDecoration.underline),),
                      ),
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(widget.restaurant.description),
                    ),
                    Text(
                      "Cuisine",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 5),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children:
                          List.generate(widget.restaurant.cuisine.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: mainGreen)), child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(widget.restaurant.cuisine[index],),
                                  ),),
                            );
                          }),

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
