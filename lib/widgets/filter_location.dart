import 'package:flutter/material.dart';
import 'package:kitajom/provider/request_provider.dart';
import 'package:kitajom/utils/colors.dart';

class FilterLocation extends StatefulWidget {
  final RequestProvider value;
  const FilterLocation({super.key, required this.value});

  @override
  State<FilterLocation> createState() => _FilterLocationState();
}

class _FilterLocationState extends State<FilterLocation> {

  List<String> _location = ["Genting Highlands", "Ipoh", "Kuantan"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: _location.length,
        itemBuilder: (context, index){
          int _selectedIndex = widget.value.locationIndex;
          String location = _location[index];
          Key tileKey = Key(location);
          return ListTile(
              title: Text(location, style: TextStyle(
                color: index == _selectedIndex ? mainGreen : Colors.black,
              ),),
              selected: index == _selectedIndex,
            onTap: () {
              setState(() {
                _selectedIndex = index;
                widget.value.setLocation(location);
                widget.value.setLocationIndex(index);
                print(location);
                widget.value.notify();
              });

            }
          );
        },
      ),
    );
  }
}
