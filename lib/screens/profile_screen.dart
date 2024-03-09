import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitajom/screens/bookmark_screen.dart';
import 'package:kitajom/screens/login_screen.dart';
import 'package:kitajom/screens/profile_setup_screen.dart';
import 'package:kitajom/utils/colors.dart';

import '../layout/layout_mobile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String firstname = "";
  String photoUrl = "";

  @override
  void initState() {
    super.initState();
    getname();
  }

  void getname() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
      firstname = (snap.data() as Map<String, dynamic>)['firstName'];
      photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.popUntil(context, (route) => route is MobileScreenLayout);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(photoUrl,
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover, frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                      return child;
                    }, loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        );
                      }
                    }),
                  ),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: lightGrey,
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      offset:
                          Offset(1.0, 1.0), // shadow direction: bottom right
                    ),
                  ], borderRadius: BorderRadius.circular(100)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(firstname, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: titleGreen),),
              Text("Username: $username"),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                             SetupScreen()));
                },
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(border: Border.all(color: white),),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 35,
                          color: mainGreen,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Manage Account"),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookmarkScreen()),
                  );
                },
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(border: Border.all(color: white),),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          size: 35,
                          color: mainGreen,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Bookmark"),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: signUserOut,
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(border: Border.all(color: white),),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 35,
                          color: mainGreen,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Sign Out"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
