import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/model/accommodation.dart';
import 'package:kitajom/provider/review_provider.dart';
import 'package:kitajom/provider/user_provider.dart';
import 'package:kitajom/widgets/accomodation_widget.dart';
import 'package:provider/provider.dart';

class AccommodationList extends StatelessWidget {
  final bool isBookmark;

  const AccommodationList({super.key, this.isBookmark = false});

  @override
  Widget build(BuildContext context) {
    bool exist = false;
    List<String> listBookmark =
        Provider.of<UserProvider>(context, listen: true).getUser.bookmark;
    var refresh = Provider.of<ReviewProvider>(context, listen: true).refresh();
    print("refresh list");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('accommodation')
              .where('isAvailable', isEqualTo: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var accommodations = snapshot.data!.docs.map((doc) {
                return Accommodation.fromSnap(doc);
              }).toList();

              accommodations.sort((a, b) => (b!.rating).compareTo(a!.rating));

              if (isBookmark == true) {
                for (Accommodation i in accommodations) {
                  if (listBookmark.contains(i.listingId)) {
                    exist = true;
                  }
                }
              }

              return (accommodations.isEmpty || (!exist && isBookmark))
                  ? const Center(child: Text("No accommodation is available!"))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: accommodations.length,
                      itemBuilder: (context, index) {
                        var accommodation = accommodations[index];
                        Key tileKey = Key(accommodation!.listingId);
                        return isBookmark
                            ? listBookmark.contains(accommodation.listingId)
                                ? AccommodationWidget(
                                    accommodation: accommodation)
                                : SizedBox()
                            : AccommodationWidget(accommodation: accommodation);
                      },
                    );
            }
          }),
    );
  }
}
