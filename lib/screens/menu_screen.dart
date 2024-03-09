import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/screens/profile_screen.dart';
import 'package:kitajom/widgets/menu_widget.dart';

import '../widgets/profile_pic.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String username = "";

  @override
  void initState() {
    super.initState();
    getUsername();
  }


  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  void navigateToProfile() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ProfileScreen(),
    ));

  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            title: Text("Menu"),
            centerTitle: true,
            actions: [
              Container(

                child: ProfilePic(),
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,



            ),
            children: [
              MenuWidget(buttonText: "Profile", icon: Icons.person,),
              MenuWidget(buttonText: "Itinerary Generation", icon: Icons.calendar_month_outlined,),
            ],
          ),
        ),
      ),
    );
  }
}
