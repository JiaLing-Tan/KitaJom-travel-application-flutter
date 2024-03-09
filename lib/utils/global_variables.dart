import 'package:flutter/material.dart';
import 'package:kitajom/screens/booking_screen.dart';
import 'package:kitajom/screens/dashboard_screen.dart';
import 'package:kitajom/screens/menu_screen.dart';


const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const DashboardScreen(),
  const MenuScreen(),
  const BookingScreen(),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];