import 'package:flutter/material.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/booking_list.dart';

import '../resources/CRUD/booking.dart';
import '../widgets/profile_pic.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String username = "";
  final BookingController bookingController = BookingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            title: const Text("Booking"),
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
                  text: "Attraction",
                )
              ],
            ),
          ),
          body: const TabBarView(children: [
            BookingList(listingType: "accommodation"),
            BookingList(listingType: "activity"),
          ]),
        ),
      ),
    );
  }
}
