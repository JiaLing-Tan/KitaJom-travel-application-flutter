import 'package:flutter/material.dart';
import 'package:kitajom/model/attraction.dart';
import 'package:kitajom/screens/attraction_detail_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/rating_widget.dart';

class AttractionWidget extends StatelessWidget {
  final Attraction attraction;

  const AttractionWidget({
    super.key,
    required this.attraction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    AttractionDetailScreen(attraction:attraction)));
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
                child:  Container(
                  height: 150,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        attraction.photos[0],
                        fit:BoxFit.cover
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 150,child: Text(attraction.listingName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
                    Row(
                      children: [
                        RatingWidget(isReview: false, rating: attraction.rating),
                        SizedBox(width: 10,),
                        Text("${attraction.rating}.0", style: TextStyle(color: Colors.grey, fontSize: 12),)
                      ],
                    ),
                    SizedBox(
                        width: 150,
                        child: Text(
                            attraction.description, maxLines: 2, overflow: TextOverflow.ellipsis,)),
                    Text(attraction.pricePoint, style: TextStyle(color: mainGreen, fontWeight: FontWeight.w800, fontSize: 17),),
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
