import 'package:flutter/material.dart';
import 'package:kitajom/utils/colors.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Leave a review for Resort World Genting - First World Hotel!"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 200, child: Text("Have you enjoyed your stay in Resort World Genting- First World Hotel? Leave a review for them!")),
              Text("31/12/2023\n23:01", textDirection: TextDirection.rtl,)
            ],
          ),
        ),
        SizedBox(height: 10,),
        Divider(color: mainGreen,)
      ],
    );
  }
}
