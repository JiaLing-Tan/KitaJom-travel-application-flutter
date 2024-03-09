import 'package:flutter/material.dart';
import 'package:kitajom/widgets/notification_widget.dart';

import '../widgets/profile_pic.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          toolbarHeight: 100,
          title: Text("Notification"),
          centerTitle: true,
          actions: [
            Container(
              child: ProfilePic(),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: Column(

          children: [
            NotificationWidget(),

          ],
        ),
    ));}}
