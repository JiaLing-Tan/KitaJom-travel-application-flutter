import 'package:flutter/material.dart';
import 'package:kitajom/resources/CRUD/restaurant.dart';
import 'package:kitajom/widgets/filterbar_short.dart';
import 'package:kitajom/widgets/restaurant_list.dart';

import '../widgets/profile_pic.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final RestaurantController restaurantController = RestaurantController();

  @override
  Widget build(BuildContext context) {
    int _counter = 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text("Restaurant"),
        centerTitle: true,
        actions: [
          Container(
            child: ProfilePic(),
          ),
        ],
      ),
      body: Column(
        children: [
          FilterBarShort(),
          RestaurantList(),
        ],
      ),
    );
  }
}
