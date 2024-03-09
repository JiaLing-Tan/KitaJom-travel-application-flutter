import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final bool isUser;
  final String HotelId;
  const QuestionWidget({super.key, required this.isUser, this.HotelId = ""});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("question 1")],);
  }
}
