import 'package:flutter/material.dart';
import 'package:kitajom/screens/notification_screen.dart';
import 'package:kitajom/screens/profile_screen.dart';
import 'package:kitajom/utils/colors.dart';

import '../screens/Itinerary_screen.dart';
import '../screens/review_screen.dart';

class MenuWidget extends StatelessWidget {
  final String buttonText;
  final IconData icon;


  const MenuWidget({
    super.key,
    required this.buttonText,
    required this.icon,
  });


  void navigateToScreen(BuildContext context) {
    if( buttonText == "Profile") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ));
    }
    else if (buttonText == "Itinerary Generation"){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ItineraryScreen(),
      ));
    }
    else if (buttonText == "Notification Center"){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      ));
    }
    else if (buttonText == "Review"){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ReviewScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: GestureDetector(
            onTap: (){navigateToScreen(context);},
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Icon(
                  icon,
                  color: white,
                  size: 60.0,
                ),
              ),
            ),
          ),
        ),
        Text(buttonText
        ),
      ],
    );
  }
}
