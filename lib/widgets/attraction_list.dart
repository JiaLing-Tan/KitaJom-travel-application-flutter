import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/model/attraction.dart';
import 'package:kitajom/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'attraction_widget.dart';

class AttractionList extends StatelessWidget {
  final bool isBookmark;

  const AttractionList({super.key, this.isBookmark = false});

  @override
  Widget build(BuildContext context) {
    bool exist = false;
    List<String> listBookmark =
        Provider.of<UserProvider>(context, listen: true).getUser.bookmark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('activity')
              .where('isAvailable', isEqualTo: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var attractions = snapshot.data!.docs.map((doc) {
                return Attraction.fromSnap(doc);
              }).toList();

              attractions.sort((a, b) => (b!.rating).compareTo(a!.rating));
              if (isBookmark == true) {
                for (Attraction i in attractions) {
                  if (listBookmark.contains(i.listingId)) {
                    exist = true;
                  }
                }
              }
              ;

              return (attractions.isEmpty || (!exist && isBookmark))
                  ? const Center(child: Text("No attraction is available!"))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: attractions.length,
                      itemBuilder: (context, index) {
                        var attraction = attractions[index];
                        Key tileKey = Key(attraction!.listingId);
                        return isBookmark
                            ? listBookmark.contains(attraction.listingId)
                                ? AttractionWidget(attraction: attraction)
                                : SizedBox()
                            : AttractionWidget(attraction: attraction);
                      },
                    );
            }
          }),
    );
  }
}
