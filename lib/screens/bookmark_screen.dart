import 'package:flutter/material.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/attraction_list.dart';
import 'package:kitajom/widgets/restaurant_list.dart';

import '../resources/CRUD/booking.dart';
import '../widgets/accommodation_list.dart';
import '../widgets/profile_pic.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  String username = "";
  final BookingController bookingController = BookingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Text("Bookmark"),
          centerTitle: true,
          actions: const [
            ProfilePic(),
          ],
          bottom: TabBar(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.grey;
                }
                return null;
              },
            ),
            indicatorWeight: 8,
            labelColor: mainGreen,
            indicatorColor: mainGreen,
            tabs: const [
              Tab(text: "Accomodation"),
              Tab(
                text: "Restaurant",
              ),
              Tab(text: "Attraction")
            ],
          ),
        ),
        body: TabBarView(children: [
          AccommodationList(isBookmark: true,),
          RestaurantList(isBookmark: true,),
          AttractionList(isBookmark: true,),

        ]),
      ),
    );
  }
}
