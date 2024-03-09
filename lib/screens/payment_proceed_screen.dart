import 'package:flutter/material.dart';
import 'package:kitajom/provider/page_provider.dart';
import 'package:kitajom/resources/timer.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:provider/provider.dart';

class PaymentProceed extends StatefulWidget {
  const PaymentProceed({super.key});

  @override
  State<PaymentProceed> createState() => _PaymentProceedState();
}

class _PaymentProceedState extends State<PaymentProceed> {
  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    final timerManager = TimerManager(
      onTimeElapsed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Provider.of<PageProvider>(context, listen: false).setPage(2);
      },
    );
    timerManager.startTimer(const Duration(seconds: 3));
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: SizedBox(width: 30,height: 30, child: Center(child: CircularProgressIndicator(color: mainGreen,)),)),
          Text("Proceeding Payment...")
        ],
      ),),
    );
  }
}
