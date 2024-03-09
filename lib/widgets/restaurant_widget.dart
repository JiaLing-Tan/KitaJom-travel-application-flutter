import 'package:flutter/material.dart';
import 'package:kitajom/model/restaurant.dart';
import 'package:kitajom/screens/restaurant_detail_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/rating_widget.dart';

class RestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  RestaurantDetailScreen(restaurant: restaurant)));
    },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
                child: Container(
                  height: 150,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      restaurant.photos[0],
                      fit:BoxFit.cover
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 150, child: Text(restaurant.listingName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
                    Row(
                      children: [
                        RatingWidget(isReview: false,
                          rating: restaurant.rating,
                        ),
                        SizedBox(width: 10,),
                        Text("${restaurant.rating}.0", style: TextStyle(color: Colors.grey, fontSize: 12),)
                      ],
                    ),
                    SizedBox(width: 150,  child: Text(restaurant.description, overflow: TextOverflow.ellipsis, maxLines: 2,)),
                    Text(restaurant.pricePoint, style: TextStyle(fontSize: 17, color: mainGreen, fontWeight: FontWeight.w800),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
