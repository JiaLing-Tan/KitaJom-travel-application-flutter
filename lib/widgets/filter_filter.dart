import 'package:flutter/material.dart';
import 'package:kitajom/provider/request_provider.dart';
import 'package:kitajom/utils/colors.dart';

class FilterFilter extends StatefulWidget {
  final RequestProvider value;
  const FilterFilter({super.key, required this.value});

  @override
  State<FilterFilter> createState() => _FilterFilterState();
}

class _FilterFilterState extends State<FilterFilter> {

  List<String> _filter = ["Outdoor", "Theme Park", "Nature", "Staycation", "Food Exploration"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (context, index){
          print(index);
          List<int> _selectedIndex = widget.value.filterIndex;
          String filter = _filter[index];
          Key tileKey = Key(filter);
          return ListTile(
              title: Text(filter, style: TextStyle(
                color: _selectedIndex.contains(index) ? mainGreen : Colors.black,
              ),),
              selected:  _selectedIndex.contains(index),
              onTap: () {
                setState(() {
                  if (_selectedIndex.contains(index)){
                    _selectedIndex.remove(index);
                    //widget.value.removeFilterIndex(index);
                    widget.value.removeFilter(filter);
                  }else {
                    _selectedIndex.add(index);
                    widget.value.setFilter(filter);

                    //widget.value.setFilterIndex(index);

                  }
                  widget.value.notify();
                });
              }
          );
        },
      ),
    );
  }
}
