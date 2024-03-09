import 'package:flutter/material.dart';
import 'package:kitajom/resources/CRUD/attraction.dart';
import 'package:kitajom/widgets/attraction_list.dart';
import 'package:kitajom/widgets/filterbar_short.dart';

import '../widgets/profile_pic.dart';

class AttractionScreen extends StatefulWidget {
  const AttractionScreen({super.key});

  @override
  State<AttractionScreen> createState() => _ExploreState();
}

class _ExploreState extends State<AttractionScreen> {
  final AttractionController attractionController = AttractionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          toolbarHeight: 100,
          title: const Text("Attractions"),
          centerTitle: true,
          actions: [
            Container(
              child: const ProfilePic(),
            ),
          ]),
      body: Column(
        children: [
          const FilterBarShort(),
          AttractionList(),
        ],
      ),
    );
  }
}
