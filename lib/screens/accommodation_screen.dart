import 'package:flutter/material.dart';
import 'package:kitajom/resources/CRUD/attraction.dart';
import 'package:kitajom/widgets/accommodation_list.dart';
import 'package:kitajom/widgets/filterbar_short.dart';

import '../widgets/profile_pic.dart';

class AccommodationScreen extends StatefulWidget {
  const AccommodationScreen({super.key});

  @override
  State<AccommodationScreen> createState() => _ExploreState();
}

class _ExploreState extends State<AccommodationScreen> {
  final AttractionController attractionController = AttractionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          toolbarHeight: 100,
          title: const Text("Accommodation"),
          centerTitle: true,
          actions: [
            Container(
              child: const ProfilePic(),
            ),
          ]),
      body: Column(
        children: [
          const FilterBarShort(),
         AccommodationList(),
        ],
      ),
    );
  }
}
