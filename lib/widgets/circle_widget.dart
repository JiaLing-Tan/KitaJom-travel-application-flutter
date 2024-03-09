import 'package:flutter/material.dart';
import 'package:kitajom/screens/accommodation_screen.dart';
import 'package:kitajom/screens/attraction_screen.dart';
import 'package:kitajom/screens/restaurant_screen.dart';
import 'package:kitajom/utils/colors.dart';

class CircleWidget extends StatelessWidget {
  final String desText;
  final IconData icon;

  const CircleWidget({
    super.key,
    required this.desText,
    required this.icon,
  });

  void navigateToScreen(BuildContext context) {
    if (desText == "Accomodation") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AccommodationScreen(),
      ));
    } else if (desText == "Restaurant") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const RestaurantScreen(),
      ));
    } else if (desText == "Attraction") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AttractionScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 85, height: 90,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: GestureDetector(
              onTap: () {
                navigateToScreen(context);
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Icon(
                    icon,
                    color: white,
                    size: 25.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
              ),
            ),
          ),
          Text(desText, style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }
}
