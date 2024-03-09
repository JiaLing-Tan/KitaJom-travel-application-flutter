import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitajom/model/user.dart' as model;

import '../storage_methods.dart';

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser({
    required String email,
    required String uid,
    required String username,
    required String lastName,
    required String firstName,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    String photoUrl =
        await StorageMethods().uploadImageToStorage('profilePics', file, false);
    try {
      if (username.isNotEmpty ||
          lastName.isNotEmpty ||
          firstName.isNotEmpty ||
          phoneNumber.isNotEmpty) {
        await _firestore.collection('user').doc(uid).set({
          'username': username,
          'uid': uid,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'role': "customer",
          'photoUrl': photoUrl,
          'phoneNumber': phoneNumber,
          'bookmark': []
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addBookmark({
    required String listingId,
  }) async {
    String res = "Some error occured";
    var list = [listingId];
    try {
      await _firestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"bookmark": FieldValue.arrayUnion(list)});
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> removeBookmark({
    required String listingId,
  }) async {
    String res = "Some error occured";
    var list = [listingId];
    try {
      await _firestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"bookmark": FieldValue.arrayRemove(list)});
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> checkBookmark({
    required String listingId,
  }) async {
    String res = "Some error occured";
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      var snapshot = documentSnapshot.data() as Map<String, dynamic>;
      List<dynamic> bookmarks = snapshot["bookmark"];
      if (bookmarks.contains(listingId) ){
        res = "exist";
      }
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

}
