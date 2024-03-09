import 'package:flutter/material.dart';

class ExploreWidget extends StatelessWidget {
  final String buttonText;
  final String imageUrl;
  final Function()? onTap;


  const ExploreWidget({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.imageUrl,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Text(
         buttonText,
        ),
      ],
    );
  }
}
