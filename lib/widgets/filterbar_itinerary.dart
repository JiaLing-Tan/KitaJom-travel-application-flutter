import 'package:flutter/material.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/filter_location.dart';
import 'package:provider/provider.dart';

import '../provider/request_provider.dart';
import 'filter_day.dart';
import 'filter_filter.dart';

class FilterBarItinerary extends StatefulWidget {
  const FilterBarItinerary({super.key});

  @override
  State<FilterBarItinerary> createState() => _FilterBarItineraryState();
}

class _FilterBarItineraryState extends State<FilterBarItinerary> {
  String date = "Day";
  String location = "Location";

  void _tapDay(RequestProvider value) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) =>
            Container(width: double.infinity, child: FilterDay(value: value)));
  }

  void _tapLocation(RequestProvider value) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
            width: double.infinity, child: FilterLocation(value: value)));
  }

  void _tapFilter(RequestProvider value) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
            width: double.infinity, child: FilterFilter(value: value)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(
        builder: (context, value, child) => Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: mainGreen)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _tapDay(value);
                            },
                            child: Row(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(Icons.date_range),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 60,
                                      child: Text(
                                        value.day == "Day"
                                            ? value.day
                                            : value.day == "1"
                                                ? value.day + " day"
                                                : value.day + " days",
                                        style: TextStyle(height: 1.2),
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              )
                            ]),
                          ),
                          VerticalDivider(
                            color: mainGreen,
                          ),
                          GestureDetector(
                            onTap: () {
                              _tapLocation(value);
                            },
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Icon(Icons.location_on),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 67,
                                        child: Text(
                                          value.location,
                                          style: TextStyle(height: 1.0),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: mainGreen,
                          ),
                          GestureDetector(
                            onTap: () {
                              _tapFilter(value);
                            },
                            child: Row(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(Icons.filter_list_alt),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Filter",
                                    style: TextStyle(height: 1.2),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Center(
                                    child: Text(
                                  value.filterIndex.length.toString(),
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w900),
                                )),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
