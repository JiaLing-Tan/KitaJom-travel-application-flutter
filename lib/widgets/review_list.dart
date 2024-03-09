  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:kitajom/model/accommodation.dart';
import 'package:kitajom/provider/review_provider.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/rating_widget.dart';
import 'package:provider/provider.dart';

  class ReviewList extends StatefulWidget {
    final String listingId;

    const ReviewList({super.key, required this.listingId});

    @override
    State<ReviewList> createState() => _ReviewListState();
  }

  class _ReviewListState extends State<ReviewList> {
    String username = "";

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

    @override
    Widget build(BuildContext context) {

      var refresh = Provider.of<ReviewProvider>(context, listen: true).refresh();
      return StreamBuilder(
        stream:  FirebaseFirestore.instance
            .collection('accommodation')
            .where('listingId', isEqualTo: widget.listingId)
            .snapshots(),
        builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            var accommodations = snapshot.data!.docs.map((doc) {
              return Accommodation.fromSnap(doc);
            }).toList();


            return accommodations[0].userReviews.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListView.builder(
                itemCount: accommodations[0].userReviews.length,
                itemBuilder: (context, index) {
                  Map<dynamic, dynamic> content = accommodations[0].userReviews[index];
                  List<dynamic> photoList = content['photoUrl'];
                  Key tileKey = Key(content["reviewId"]);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingWidget(
                        rating: content['rating'],
                        isReview: false,
                      ),
                      Text(
                        content["description"],
                      ),
                      (content["photoUrl"].isNotEmpty)
                          ? Container(
                        height: 58,
                        child: ListView.builder(
                            itemCount: photoList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Key tileKey = Key(photoList[index]);
                              print("list index");
                              print(photoList[index]);
                              print("list ");
                              print(photoList);
                              print("index");
                              print(index);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: FullScreenWidget(
                                    disposeLevel: DisposeLevel.Low,
                                    child: Image.network(
                                        photoList[index], fit: BoxFit.cover,
                                        frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) {
                                          print(
                                              "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                          print(
                                              "------------------------------------------------------------------------------------");
                                          print("list index");
                                          print(photoList[index]);
                                          print("list ");
                                          print(photoList);
                                          print("index");
                                          print(index);
                                          return child;
                                        },
                                        loadingBuilder: (context, child,
                                            loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                        }),
                                  ),
                                ),
                              );
                            }),
                      )
                          : SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: mainGreen,
                      )
                    ],
                  );
                },
              ),
            )
                : Center(child: Text("No review yet"));
          }
        });
    }
  }
