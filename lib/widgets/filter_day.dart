import 'package:flutter/material.dart';
import 'package:kitajom/provider/request_provider.dart';
import 'package:kitajom/utils/colors.dart';

class FilterDay extends StatefulWidget {
  final RequestProvider value;

  const FilterDay({super.key, required this.value});

  @override
  State<FilterDay> createState() => _FilterDayState();
}

class _FilterDayState extends State<FilterDay> {
  List<String> _day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: _day.length,
        itemBuilder: (context, index) {
          print(widget.value.day);
          try{
            _selectedIndex = int.parse(widget.value.day) - 1;
          }
          catch(e){
            _selectedIndex = 0;

          };
          String day = _day[index];
          Key tileKey = Key(day);
          print(day);
          return ListTile(
              title: Text(
                day,
                style: TextStyle(
                  color: index == _selectedIndex ? mainGreen : Colors.black,
                ),
              ),
              selected: index == _selectedIndex,
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  widget.value.setDay(day);
                  print(day);
                  widget.value.notify();
                });
              });
        },
      ),
    );
  }
}
