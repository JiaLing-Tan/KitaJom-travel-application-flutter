import

'package:flutter/material.dart';
import 'package:kitajom/screens/dashboard_screen.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/widgets/button.dart';
import 'package:kitajom/widgets/image_review.dart';

import '../widgets/textbox.dart';
import 'notification_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final list = [
    'Refund',
    'Modification',
    'Complaint',
    'Enquiries'
  ];
  String? value;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        DashboardScreen.showBackDialog('Discard report and leave?', context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            toolbarHeight: 100,
            title: Text("Request"),
            centerTitle: true,
            ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Request Type  :"),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: value,
                                items: list.map(buildMenuItem).toList(),
                                onChanged: (value) => setState(() {
                                  this.value = value;
                                }))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Description : "),
                            SizedBox(
                              height: 10,
                            ),
                            TextBoxInput(
                              controller: _descriptionController,
                              hintText: "Write about your experience and feedback...",
                            )
                          ],
                        ),
                      ),
                      ImageReview(),
                      SizedBox(
                        width: 300,
                        height: 47,
                        child: MyButton(
                          buttonText: "Save Rating",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NotificationScreen()),
                            );
                          },
                          color: mainGreen,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item, style: TextStyle(fontSize: 15)));
}
