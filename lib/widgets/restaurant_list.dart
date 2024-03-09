import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/model/restaurant.dart';
import 'package:kitajom/provider/filter_provider.dart';
import 'package:kitajom/provider/user_provider.dart';
import 'package:kitajom/widgets/restaurant_widget.dart';
import 'package:provider/provider.dart';

class RestaurantList extends StatelessWidget {
  List<String> filter;
  final bool isBookmark;

  RestaurantList(
      {super.key, this.isBookmark = false, this.filter = const ["ok"]});

  @override
  Widget build(BuildContext context) {
    bool exist = false;
    List<String> listBookmark =
        Provider.of<UserProvider>(context, listen: true).getUser.bookmark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('restaurant')
              .where('isAvailable', isEqualTo: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var restaurants = snapshot.data!.docs.map((doc) {
                return Restaurant.fromSnap(doc);
              }).toList();

              restaurants.sort((a, b) => (b!.rating).compareTo(a!.rating));

              if (isBookmark == true) {
                for (Restaurant i in restaurants) {
                  if (listBookmark.contains(i.listingId)) {
                    exist = true;
                  }
                }
              }

              return (restaurants.isEmpty || (!exist && isBookmark))
                  ? const Center(child: Text("No restaurant is available!"))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = restaurants[index];
                        Key tileKey = Key(restaurant!.listingId);
                        filter =
                            Provider.of<FilterProvider>(context, listen: true)
                                .location
                                .toLowerCase()
                                .split(" ");
                        print(filter);

                        List<String> address = restaurant.address
                            .toLowerCase()
                            .split(RegExp(r"\s+|,"));
                        print(address);
                        address.remove("");
                        return (filter[0] == "ok")
                            ? (isBookmark
                                ? listBookmark.contains(restaurant.listingId)
                                    ? RestaurantWidget(restaurant: restaurant)
                                    : SizedBox()
                                : RestaurantWidget(restaurant: restaurant))
                            : Set.from(address)
                                    .intersection(Set.from(filter))
                                    .isEmpty
                                ? SizedBox()
                                : RestaurantWidget(restaurant: restaurant);
                      },
                    );
            }
          }),
    );
  }
}
