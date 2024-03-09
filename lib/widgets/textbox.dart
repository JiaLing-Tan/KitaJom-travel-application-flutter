import 'package:flutter/material.dart';
import 'package:kitajom/utils/colors.dart';

class TextBoxInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const TextBoxInput({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.90,
      height: 200,

      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: lightGrey,
        ),

        // gradient: LinearGradient(
        //   colors: [lightGrey, white],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   stops: [0.0, 0.4],
        //   tileMode: TileMode.clamp,
        // ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          cursorColor:mainGreen,
          controller: controller,
          decoration: InputDecoration(
            // enabledBorder: OutlineInputBorder(),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: titleGreen),
            // ),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
        ),
      ),
    );
  }
}
