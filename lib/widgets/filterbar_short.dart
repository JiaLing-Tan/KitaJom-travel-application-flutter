import 'package:flutter/material.dart';
import 'package:kitajom/provider/filter_provider.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:provider/provider.dart';

class FilterBarShort extends StatefulWidget {
  const FilterBarShort({super.key});

  @override
  State<FilterBarShort> createState() => _FilterBarShortState();
}

class _FilterBarShortState extends State<FilterBarShort> {
  String date = "Date";
  List<String> _location = ["Subang", "Puchong"];

  void setLocation(FilterProvider value) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: _location.length,
                itemBuilder: (context, index) {
                  int _selectedIndex =
                      Provider.of<FilterProvider>(context, listen: true)
                          .locationIndex;
                  String location = _location[index];
                  Key tileKey = Key(location);
                  return ListTile(
                      title: Text(
                        location,
                        style: TextStyle(
                          color: index == _selectedIndex
                              ? mainGreen
                              : Colors.black,
                        ),
                      ),
                      selected: index == _selectedIndex,
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          value.setLocation(location);
                          value.setLocationIndex(index);
                          value.notify();
                        });
                      });
                },
              ),
            )));
  }

  //
  // void _setDate() {
  //   setState(() {
  //     date = "oi";
  //   });
  // }
  //

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: mainGreen)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setLocation(value);
                    },
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                          ),
                          Icon(Icons.location_on),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 70,
                              child: Text(
                                (value.location == "ok")
                                    ? "Location"
                                    : value.location,
                                style: TextStyle(height: 1.2),
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ]),
                  ),
                  VerticalDivider(
                    color: mainGreen,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 70,
                            ),
                            Icon(Icons.filter_list_alt),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 70, child: Text("Filter")),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
