import 'package:flutter/material.dart';
import 'package:kitajom/utils/colors.dart';

class AmenitiesWidget extends StatefulWidget {
  final String amenity;

  const AmenitiesWidget({super.key, required this.amenity});

  @override
  State<AmenitiesWidget> createState() => _AmenitiesWidgetState();
}

class _AmenitiesWidgetState extends State<AmenitiesWidget> {

  final Map<String, IconData> iconMap = {
    "Kitchenette": Icons.kitchen,
    "TV": Icons.tv,
    "Swimming Pool": Icons.pool,
    "WiFi": Icons.wifi,
    "Games": Icons.gamepad_outlined,
    "Washing machine": Icons.dry_cleaning_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final String amenity = widget.amenity.trim();
    final IconData icon = iconMap[amenity] ?? Icons.room_service; // Use default icon for unknown amenities

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                border: Border.all(color: mainGreen)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [Icon(icon, size: 20,), SizedBox(width: 8,),Text(amenity, style: TextStyle(fontSize: 12),)
              ],),
            ),),
        ],
      ), // Use separate widget for container
    );
  }
}

