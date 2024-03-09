import 'package:flutter/material.dart';

class Selection extends StatefulWidget {
  final Function()? onTap;
  final String buttonText;
  final Color color;


  const Selection({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.color,
  });

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 120),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
