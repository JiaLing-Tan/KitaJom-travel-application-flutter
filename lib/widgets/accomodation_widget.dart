import 'package:flutter/material.dart';
import 'package:kitajom/model/accommodation.dart';
import 'package:kitajom/provider/review_provider.dart';
import 'package:kitajom/screens/accommodation_detail_screen.dart';
import 'package:kitajom/widgets/rating_widget.dart';
import 'package:provider/provider.dart';

class AccommodationWidget extends StatelessWidget {
  final Accommodation accommodation;
  const AccommodationWidget({super.key, required this.accommodation});

  @override
  Widget build(BuildContext context) {

    var refresh = Provider.of<ReviewProvider>(context, listen: true).refresh();
    print("refresh widget");
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    AccommodationDetailScreen(accommodation: accommodation,)));
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
                child: SizedBox(
                  height: 150,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      accommodation.photos[0],
                      fit: BoxFit.cover,
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
                    SizedBox(width: 150,child: Text(accommodation.listingName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
                    Row(
                      children: [
                        RatingWidget(isReview: false, rating: accommodation.rating),
                        SizedBox(width: 10,),
                        Text("${accommodation.rating}.0", style: TextStyle(color: Colors.grey, fontSize: 12),)
                      ],
                    ),
                    SizedBox(
                        width: 150,

                        child: Text(
                            accommodation.description, overflow: TextOverflow.ellipsis,maxLines: 2,)),

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
