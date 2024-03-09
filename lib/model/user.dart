import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String lastName;
  final String firstName;
  final String uid;
  final String phoneNumber;
  final String role;
  final String photoUrl;
  late final List<String> bookmark;

 User(
      {required this.email,
      required this.lastName,
      required this.firstName,
      required this.username,
      required this.uid,
      required this.phoneNumber,
      required this.photoUrl,
      required this.role,
      required this.bookmark});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        username: snapshot["username"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        firstName: snapshot["firstName"],
        lastName: snapshot["lastName"],
        phoneNumber: snapshot["phoneNumber"],
        photoUrl: snapshot["photoUrl"],
        role: snapshot["role"],
        bookmark: snapshot["bookmark"]?.cast<String>() ?? []);
  }

  Map<String, dynamic> toJson() => {};
}
