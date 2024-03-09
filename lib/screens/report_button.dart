import 'package:flutter/material.dart';
import 'package:kitajom/screens/report_screen.dart';
import 'package:kitajom/utils/colors.dart';

class ReportButton extends StatelessWidget {

  const ReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ReportScreen(),
          ));
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Icon(
            Icons.report_problem_rounded,
            color: mainGreen,
            size: 30,
          ),
        ),
      ),
    );
  }
}
